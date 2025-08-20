import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/providers/question_list_provider.dart';
import 'dart:convert';

class AddEditQuestionScreen extends ConsumerStatefulWidget {
  final Question? question;
  final int bankId;

  const AddEditQuestionScreen({super.key, this.question, required this.bankId});

  @override
  ConsumerState<AddEditQuestionScreen> createState() =>
      _AddEditQuestionScreenState();
}

class _AddEditQuestionScreenState extends ConsumerState<AddEditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _content;
  late String _type;
  late String _explanation;
  late String _tags;

  List<TextEditingController> _optionControllers = [];
  // For single choice
  int? _singleChoiceAnswerIndex;
  // For multiple choice
  List<bool> _multipleChoiceAnswers = [];

  final List<String> _questionTypes = ['单选', '多选', '判断'];

  @override
  void initState() {
    super.initState();
    _type = widget.question?.type ?? _questionTypes.first;
    _content = widget.question?.content ?? '';
    _explanation = widget.question?.explanation ?? '';
    _tags = widget.question?.tags ?? '';

    if (widget.question != null) {
      final options = jsonDecode(widget.question!.options) as List;
      _optionControllers = options
          .map((o) => TextEditingController(text: o.toString()))
          .toList();
      final answer = jsonDecode(widget.question!.answer);
      if (_type == '单选' || _type == '判断') {
        _singleChoiceAnswerIndex = answer == null ? 0 : answer as int;
      } else if (_type == '多选') {
        _multipleChoiceAnswers = (answer as List)
            .map((a) => a as bool)
            .toList();
      }
    } else {
      // Start with 2 empty options
      _optionControllers = List.generate(2, (_) => TextEditingController());
      _multipleChoiceAnswers = List.generate(2, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question == null ? '添加题目' : '编辑题目'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _content,
                decoration: const InputDecoration(labelText: '题干'),
                validator: (value) => value!.isEmpty ? '请输入题干' : null,
                onSaved: (value) => _content = value!,
              ),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: '题目类型'),
                items: _questionTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                    if (_type == '判断') {
                      _optionControllers = [
                        TextEditingController(text: '正确'),
                        TextEditingController(text: '错误'),
                      ];
                      _multipleChoiceAnswers = [false, false];
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              Text('选项和答案', style: Theme.of(context).textTheme.titleMedium),
              _buildOptions(),
              if (_type != '判断')
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('添加选项'),
                    onPressed: () {
                      setState(() {
                        _optionControllers.add(TextEditingController());
                        _multipleChoiceAnswers.add(false);
                      });
                    },
                  ),
                ),
              TextFormField(
                initialValue: _explanation,
                decoration: const InputDecoration(labelText: '解析'),
                onSaved: (value) => _explanation = value!,
              ),
              TextFormField(
                initialValue: _tags,
                decoration: const InputDecoration(labelText: '标签 (逗号分隔)'),
                onSaved: (value) => _tags = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _optionControllers.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _optionControllers[index],
                decoration: InputDecoration(labelText: '选项 ${index + 1}'),
                validator: (value) => value!.isEmpty ? '选项不能为空' : null,
                readOnly: _type == '判断',
              ),
            ),
            if (_type == '单选' || _type == '判断')
              Radio<int>(
                value: index,
                groupValue: _singleChoiceAnswerIndex,
                onChanged: (value) {
                  setState(() {
                    _singleChoiceAnswerIndex = value;
                  });
                },
              ),
            if (_type == '多选')
              Checkbox(
                value: _multipleChoiceAnswers[index],
                onChanged: (value) {
                  setState(() {
                    _multipleChoiceAnswers[index] = value!;
                  });
                },
              ),
            if (_type != '判断' && _optionControllers.length > 2)
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  setState(() {
                    _optionControllers.removeAt(index);
                    _multipleChoiceAnswers.removeAt(index);
                  });
                },
              ),
          ],
        );
      },
    );
  }

  void _saveForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (((_type == '单选' || _type == '判断') &&
            _singleChoiceAnswerIndex == null) ||
        (_type == '多选' && !_multipleChoiceAnswers.contains(true))) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请设置答案')));
      return;
    }

    _formKey.currentState!.save();

    final options = _optionControllers.map((c) => c.text).toList();
    final String answer;
    if (_type == '单选') {
      answer = jsonEncode(_singleChoiceAnswerIndex);
    } else if (_type == '多选') {
      answer = jsonEncode(_multipleChoiceAnswers);
    } else {
      // 判断
      answer = jsonEncode(_singleChoiceAnswerIndex);
    }

    final question = Question(
      id: widget.question?.id,
      content: _content,
      type: _type,
      options: jsonEncode(options),
      answer: answer,
      explanation: _explanation,
      tags: _tags,
      bankId: widget.bankId,
      createdAt: widget.question?.createdAt ?? DateTime.now(),
    );
    if (widget.question == null) {
      ref
          .read(questionListProvider(widget.bankId).notifier)
          .addQuestion(question);
    } else {
      ref
          .read(questionListProvider(widget.bankId).notifier)
          .updateQuestion(question);
    }
    context.pop();
  }

  @override
  void dispose() {
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
