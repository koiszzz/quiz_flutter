import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/providers/bank_list_provider.dart';

class BankScreen extends ConsumerStatefulWidget {
  const BankScreen({super.key});

  @override
  ConsumerState<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends ConsumerState<BankScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<QuestionBank>> bankList = ref.watch(bankListProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('题库管理'),
      ),
      body: switch (bankList) {
        AsyncData(:final value) =>
          value.isNotEmpty
              ? ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final bank = value[index];
                    return ListTile(
                      title: Text(bank.name),
                      subtitle: Text(bank.description ?? ''),
                      onTap: () =>
                          context.go('/bank/${bank.id}/questions', extra: bank),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await ref
                              .read(bankListProvider.notifier)
                              .deleteBank(bank.id!);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(content: Text('题库已删除')),
                              );
                          }
                        },
                      ),
                    );
                  },
                )
              : const Center(child: Text('还没有题库，快添加一个吧！')),
        AsyncError() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      },
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'addBank',
            onPressed: () => _showAddBankDialog(context),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'importExcel',
            onPressed: () => _importFromExcel(context),
            child: const Icon(Icons.upload_file),
          ),
        ],
      ),
    );
  }

  Future<void> _importFromExcel(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result == null) return;
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('批量导入题库'),
            content: const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('正在导入，请稍候...'),
                ],
              ),
            ),
          );
        },
      );
    }

    try {
      final file = File(result.files.single.path!);
      final bytes = await file.readAsBytes();
      final excel = Excel.decodeBytes(bytes);

      final sheet = excel.tables[excel.tables.keys.first];
      if (sheet == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Excel文件为空')));
        }
        return;
      }

      final bankName = p.basenameWithoutExtension(file.path);
      final newBank = QuestionBank(name: bankName, createdAt: DateTime.now());
      final bankId = await ref.read(bankListProvider.notifier).addBank(newBank);

      // 获取表头
      final headerRow = sheet.rows.first;
      final header = headerRow
          .map((cell) => cell?.value.toString().trim())
          .toList();

      final contentIndex = header.indexOf('试题题干（必填）');
      final typeIndex = header.indexOf('试题类型');
      final answerIndex = header.indexOf('答案（必填）');
      // "解析" 和 "标签" 是可选的
      final explanationIndex = header.indexOf('试题解析');
      final tagsIndex = header.indexOf('标签');

      if (contentIndex == -1 || typeIndex == -1 || answerIndex == -1) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Excel格式错误，必须包含 "试题题干（必填）", "试题类型", "答案（必填）"'),
              ),
            );
        }
        return;
      }

      // 选项列是答案之后的所有列
      final optionIndices = header
          .asMap()
          .entries
          .where((entry) => entry.value?.contains('选项') == true)
          .map((entry) => entry.key)
          .toList();

      for (var i = 1; i < sheet.rows.length; i++) {
        final row = sheet.rows[i];
        if (row.every(
          (cell) => cell == null || cell.value.toString().isEmpty,
        )) {
          continue;
        }

        final content = row[contentIndex]?.value?.toString() ?? '';
        final type = row[typeIndex]?.value?.toString() ?? '';
        final rawAnswer = row[answerIndex]?.value?.toString() ?? '';
        final explanation = explanationIndex != -1
            ? row[explanationIndex]?.value?.toString() ?? ''
            : '';
        final tags = tagsIndex != -1
            ? row[tagsIndex]?.value?.toString() ?? ''
            : '';

        List<String> options = [];
        String encodedAnswer;

        switch (type) {
          case '单选':
            options = optionIndices
                .map(
                  (index) => index < row.length
                      ? row[index]?.value?.toString() ?? ''
                      : '',
                )
                .where((o) => o.isNotEmpty)
                .toList();
            final answerOptionIndex =
                rawAnswer.toUpperCase().codeUnitAt(0) - 'A'.codeUnitAt(0);
            encodedAnswer = jsonEncode(answerOptionIndex);
            break;
          case '多选':
            options = optionIndices
                .map(
                  (index) => index < row.length
                      ? row[index]?.value?.toString() ?? ''
                      : '',
                )
                .where((o) => o.isNotEmpty)
                .toList();
            final answerChars = rawAnswer
                .toUpperCase()
                .replaceAll(RegExp(r'[^A-Z]'), '')
                .split('');
            List<bool> answers = List.generate(options.length, (_) => false);
            for (var char in answerChars) {
              final index = char.codeUnitAt(0) - 'A'.codeUnitAt(0);
              if (index < answers.length) {
                answers[index] = true;
              }
            }
            encodedAnswer = jsonEncode(answers);
            break;
          case '判断':
            options = ['正确', '错误'];
            encodedAnswer = jsonEncode(rawAnswer == '正确' ? 0 : 1);
            break;
          default:
            // 不支持的类型，跳过
            continue;
        }

        final question = Question(
          content: content,
          type: type,
          options: jsonEncode(options),
          answer: encodedAnswer,
          explanation: explanation,
          tags: tags,
          bankId: bankId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          takingTimes: 0,
          lastTakenAt: DateTime.now(),
          uncorrectTimes: 0,
        );
        await ref.read(bankListProvider.notifier).addQuestion(question);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('导入成功')));
      }
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _showAddBankDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final bankProvider = ref.read(bankListProvider.notifier);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('添加新题库'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: '题库名称'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: '描述'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  final newBank = QuestionBank(
                    name: nameController.text,
                    description: descriptionController.text,
                    createdAt: DateTime.now(),
                  );
                  await bankProvider.addBank(newBank);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('添加'),
            ),
          ],
        );
      },
    );
  }
}
