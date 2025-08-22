import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/providers/bank_list_provider.dart';
import 'package:quiz_flutter/services/database_helper.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  bool _isPracticeExpanded = true;
  bool _isExamExpanded = false;

  final _practiceFormKey = GlobalKey<FormState>();
  final _examFormKey = GlobalKey<FormState>();

  // Practice Mode State
  int? _practiceSelectedBankId;
  final _practiceSingleController = TextEditingController(text: '0');
  final _practiceMultipleController = TextEditingController(text: '0');
  final _practiceTrueFalseController = TextEditingController(text: '0');
  final _practiceDurationController = TextEditingController(text: '0');
  bool _practiceShuffleQuestions = false;
  bool _practiceShuffleOptions = false;

  // Exam Mode State
  int? _examSelectedBankId;
  final _examSingleController = TextEditingController(text: '0');
  final _examMultipleController = TextEditingController(text: '0');
  final _examTrueFalseController = TextEditingController(text: '0');
  final _examDurationController = TextEditingController(text: '0');
  bool _examShuffleQuestions = true;
  bool _examShuffleOptions = true;

  final Map<int, int> _singleCount = {};
  final Map<int, int> _multipleCount = {};
  final Map<int, int> _trueFalseCount = {};

  @override
  void dispose() {
    _practiceSingleController.dispose();
    _practiceMultipleController.dispose();
    _practiceTrueFalseController.dispose();
    _practiceDurationController.dispose();
    _examSingleController.dispose();
    _examMultipleController.dispose();
    _examTrueFalseController.dispose();
    _examDurationController.dispose();
    super.dispose();
  }

  void _updateDuration(String mode) {
    int single =
        int.tryParse(
          mode == 'practice'
              ? _practiceSingleController.text
              : _examSingleController.text,
        ) ??
        0;
    int multiple =
        int.tryParse(
          mode == 'practice'
              ? _practiceMultipleController.text
              : _examMultipleController.text,
        ) ??
        0;
    int trueFalse =
        int.tryParse(
          mode == 'practice'
              ? _practiceTrueFalseController.text
              : _examTrueFalseController.text,
        ) ??
        0;
    final total = single + multiple + trueFalse;
    if (mode == 'practice') {
      _practiceDurationController.text = total.toString();
    } else {
      _examDurationController.text = total.toString();
    }
  }

  Future<void> _onBankSelected(int? bankId, String mode) async {
    if (bankId == null) return;

    final questions = await DatabaseHelper.instance.getQuestionCountsByBank(
      bankId,
    );
    _singleCount[bankId] = questions['单选'] ?? 0;
    _multipleCount[bankId] = questions['多选'] ?? 0;
    _trueFalseCount[bankId] = questions['判断'] ?? 0;

    setState(() {
      if (mode == 'practice') {
        _practiceSelectedBankId = bankId;
        _practiceSingleController.text = (_singleCount[bankId] ?? 0).toString();
        _practiceMultipleController.text = (_multipleCount[bankId] ?? 0)
            .toString();
        _practiceTrueFalseController.text = (_trueFalseCount[bankId] ?? 0)
            .toString();
      } else {
        _examSelectedBankId = bankId;
        _examSingleController.text = (_singleCount[bankId] ?? 0).toString();
        _examMultipleController.text = (_multipleCount[bankId] ?? 0).toString();
        _examTrueFalseController.text = (_trueFalseCount[bankId] ?? 0)
            .toString();
      }
      _updateDuration(mode);
    });
  }

  void _startQuiz(String mode) {
    final formKey = mode == 'practice' ? _practiceFormKey : _examFormKey;
    if (formKey.currentState!.validate()) {
      final bankId = mode == 'practice'
          ? _practiceSelectedBankId
          : _examSelectedBankId;
      final single = mode == 'practice'
          ? _practiceSingleController.text
          : _examSingleController.text;
      final multiple = mode == 'practice'
          ? _practiceMultipleController.text
          : _examMultipleController.text;
      final trueFalse = mode == 'practice'
          ? _practiceTrueFalseController.text
          : _examTrueFalseController.text;
      final duration = mode == 'practice'
          ? _practiceDurationController.text
          : _examDurationController.text;
      final shuffleQuestions = mode == 'practice'
          ? _practiceShuffleQuestions
          : _examShuffleQuestions;
      final shuffleOptions = mode == 'practice'
          ? _practiceShuffleOptions
          : _examShuffleOptions;

      context.go(
        '/quiz/taking/$mode/$bankId?single=$single&multiple=$multiple&trueFalse=$trueFalse&duration=$duration&shuffleQuestions=$shuffleQuestions&shuffleOptions=$shuffleOptions',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bankListAsync = ref.watch(bankListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('答题模式'),
      ),
      body: bankListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (banks) {
          if (banks.isEmpty) {
            return const Center(child: Text('没有可用的题库，请先创建题库。'));
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    if (index == 0) {
                      _isPracticeExpanded = !_isPracticeExpanded;
                    } else {
                      _isExamExpanded = !_isExamExpanded;
                    }
                  });
                },
                children: [
                  _buildPanel(
                    'practice',
                    '练习模式',
                    '按题库顺序或随机练习',
                    Icons.psychology_alt,
                    _isPracticeExpanded,
                    banks,
                  ),
                  _buildPanel(
                    'exam',
                    '考试模式',
                    '模拟真实考试，计时计分',
                    Icons.assignment,
                    _isExamExpanded,
                    banks,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  ExpansionPanel _buildPanel(
    String mode,
    String title,
    String subtitle,
    IconData icon,
    bool isExpanded,
    List<QuestionBank> banks,
  ) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          leading: Icon(
            icon,
            size: 40,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          subtitle: Text(subtitle),
        );
      },
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: mode == 'practice' ? _practiceFormKey : _examFormKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: mode == 'practice'
                    ? _practiceSelectedBankId
                    : _examSelectedBankId,
                decoration: const InputDecoration(
                  labelText: '选择题库',
                  border: OutlineInputBorder(),
                ),
                items: banks.map((bank) {
                  return DropdownMenuItem<int>(
                    value: bank.id,
                    child: Text(bank.name),
                  );
                }).toList(),
                onChanged: (value) => _onBankSelected(value, mode),
                validator: (value) => value == null ? '请选择一个题库' : null,
              ),
              const SizedBox(height: 16),
              _buildNumberInput(
                mode,
                '单选题数量',
                mode == 'practice'
                    ? _practiceSingleController
                    : _examSingleController,
                _singleCount[mode == 'practice'
                        ? _practiceSelectedBankId
                        : _examSelectedBankId] ??
                    0,
              ),
              const SizedBox(height: 16),
              _buildNumberInput(
                mode,
                '多选题数量',
                mode == 'practice'
                    ? _practiceMultipleController
                    : _examMultipleController,
                _multipleCount[mode == 'practice'
                        ? _practiceSelectedBankId
                        : _examSelectedBankId] ??
                    0,
              ),
              const SizedBox(height: 16),
              _buildNumberInput(
                mode,
                '判断题数量',
                mode == 'practice'
                    ? _practiceTrueFalseController
                    : _examTrueFalseController,
                _trueFalseCount[mode == 'practice'
                        ? _practiceSelectedBankId
                        : _examSelectedBankId] ??
                    0,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: mode == 'practice'
                    ? _practiceDurationController
                    : _examDurationController,
                decoration: const InputDecoration(
                  labelText: '练习/考试时长 (分钟)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入时长';
                  }
                  if (int.tryParse(value) == 0) {
                    return '时长不能为0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('题目乱序'),
                value: mode == 'practice'
                    ? _practiceShuffleQuestions
                    : _examShuffleQuestions,
                onChanged: (value) {
                  setState(() {
                    if (mode == 'practice') {
                      _practiceShuffleQuestions = value;
                    } else {
                      _examShuffleQuestions = value;
                    }
                  });
                },
              ),
              SwitchListTile(
                title: const Text('选项乱序'),
                value: mode == 'practice'
                    ? _practiceShuffleOptions
                    : _examShuffleOptions,
                onChanged: (value) {
                  setState(() {
                    if (mode == 'practice') {
                      _practiceShuffleOptions = value;
                    } else {
                      _examShuffleOptions = value;
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _startQuiz(mode),
                child: const Text('开始'),
              ),
            ],
          ),
        ),
      ),
      isExpanded: isExpanded,
    );
  }

  Widget _buildNumberInput(
    String mode,
    String label,
    TextEditingController controller,
    int max,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '$label (最多: $max)',
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入数量';
        }
        final n = int.tryParse(value);
        if (n == null) {
          return '请输入有效数字';
        }
        if (n > max) {
          return '不能超过题库中的题目总数 ($max)';
        }
        return null;
      },
      onChanged: (_) => _updateDuration(mode),
    );
  }
}
