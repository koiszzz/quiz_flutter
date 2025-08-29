import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart'; // 需要这个来使用 compute 函数

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:quiz_flutter/l10n/app_localizations.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/providers/bank_list_provider.dart';

class _ExcelParsePayload {
  final Uint8List fileBytes;
  final String trueStr;
  final String falseStr;
  final String errorMsgHeader;
  final String errorMsgEmpty;

  _ExcelParsePayload({
    required this.fileBytes,
    required this.trueStr,
    required this.falseStr,
    required this.errorMsgHeader,
    required this.errorMsgEmpty,
  });
}

Future<List<Question>> _parseExcelData(_ExcelParsePayload payload) async {
  // 1. 解码Excel文件
  final excel = Excel.decodeBytes(payload.fileBytes);
  final sheet = excel.tables[excel.tables.keys.first];
  if (sheet == null) {
    // 抛出异常，主线程会捕获它
    throw Exception(payload.errorMsgEmpty);
  }

  // 2. 解析表头
  final headerRow = sheet.rows.first;
  final header = headerRow
      .map((cell) => cell?.value.toString().trim())
      .toList();

  final contentIndex = header.indexOf('试题题干（必填）');
  final typeIndex = header.indexOf('试题类型');
  final answerIndex = header.indexOf('答案（必填）');
  final explanationIndex = header.indexOf('试题解析');
  final tagsIndex = header.indexOf('标签');

  if (contentIndex == -1 || typeIndex == -1 || answerIndex == -1) {
    throw Exception(payload.errorMsgHeader);
  }

  final optionIndices = header
      .asMap()
      .entries
      .where((entry) => entry.value?.contains('选项') == true)
      .map((entry) => entry.key)
      .toList();

  final List<Question> questions = [];
  final Map<String, String> typeMap = {
    "单选": "single",
    "多选": "multiple",
    "判断": "judge",
  };

  // 3. 遍历行并创建Question对象
  for (var i = 1; i < sheet.rows.length; i++) {
    final row = sheet.rows[i];
    if (row.every((cell) => cell == null || cell.value.toString().isEmpty)) {
      continue;
    }

    final content = row[contentIndex]?.value?.toString() ?? '';
    if (content.isEmpty) continue; // 如果核心内容为空，则跳过此行

    final type = typeMap[row[typeIndex]?.value?.toString() ?? '单选'] ?? '';
    final rawAnswer = row[answerIndex]?.value?.toString() ?? '';
    final explanation = explanationIndex != -1
        ? row[explanationIndex]?.value?.toString() ?? ''
        : '';
    final tags = tagsIndex != -1 ? row[tagsIndex]?.value?.toString() ?? '' : '';

    List<String> options = [];
    String encodedAnswer;

    switch (type) {
      case 'single':
        options = optionIndices
            .map(
              (index) =>
                  index < row.length ? row[index]?.value?.toString() ?? '' : '',
            )
            .where((o) => o.isNotEmpty)
            .toList();
        final answerOptionIndex =
            rawAnswer.toUpperCase().codeUnitAt(0) - 'A'.codeUnitAt(0);
        encodedAnswer = jsonEncode(answerOptionIndex);
        break;
      case 'multiple':
        options = optionIndices
            .map(
              (index) =>
                  index < row.length ? row[index]?.value?.toString() ?? '' : '',
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
          if (index >= 0 && index < answers.length) {
            answers[index] = true;
          }
        }
        encodedAnswer = jsonEncode(answers);
        break;
      case 'judge':
        options = [payload.trueStr, payload.falseStr];
        encodedAnswer = jsonEncode(rawAnswer == payload.trueStr ? 0 : 1);
        break;
      default:
        continue;
    }

    questions.add(
      Question(
        content: content,
        type: type,
        options: jsonEncode(options),
        answer: encodedAnswer,
        explanation: explanation,
        tags: tags,
        bankId: -1, // 临时bankId，将在主线程中更新
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        takingTimes: 0,
        lastTakenAt: DateTime.now(),
        uncorrectTimes: 0,
      ),
    );
  }
  return questions;
}

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
        title: Text(AppLocalizations.of(context)!.bankManage),
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
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!.bankRemoveMsg,
                                  ),
                                ),
                              );
                          }
                        },
                      ),
                    );
                  },
                )
              : Center(child: Text(AppLocalizations.of(context)!.bankEmptyMsg)),
        AsyncError() => Text(AppLocalizations.of(context)!.unexpectedErrorMsg),
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
            title: Text(AppLocalizations.of(context)!.bankBatchImport),
            content: SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.importWaitingMsg),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    try {
      final file = File(result.files.single.path!);
      final bytes = await file.readAsBytes();

      // 在调用 compute 之前，从 context 获取所有需要的数据
      // ignore: use_build_context_synchronously
      final l10n = AppLocalizations.of(context)!;
      final payload = _ExcelParsePayload(
        fileBytes: bytes,
        trueStr: l10n.trueStr,
        falseStr: l10n.falseStr,
        errorMsgEmpty: l10n.excelEmptyMsg,
        errorMsgHeader:
            'Excel格式错误，必须包含 "试题题干（必填）", "试题类型", "答案（必填）"', // 也可以本地化这个
      );

      // 使用 compute 在后台Isolate中执行耗时操作
      final parsedQuestions = await compute(_parseExcelData, payload);

      if (parsedQuestions.isEmpty) {
        // ignore: use_build_context_synchronously
        throw Exception(AppLocalizations.of(context)!.excelEmptyMsg);
      }

      // 回到UI线程，执行数据库操作
      final bankName = p.basenameWithoutExtension(file.path);
      final newBank = QuestionBank(name: bankName, createdAt: DateTime.now());
      final bankId = await ref.read(bankListProvider.notifier).addBank(newBank);

      // 更新问题的bankId并添加到数据库
      final questionsWithBankId = parsedQuestions.map((q) {
        return q.copyWith(bankId: bankId);
      }).toList();

      await ref
          .read(bankListProvider.notifier)
          .addQuestions(questionsWithBankId);

      // ignore: use_build_context_synchronously
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.importSuccessMsg, // 假设你有这个本地化字符串
              ),
            ),
          );
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
          title: Text(AppLocalizations.of(context)!.addBank),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addBankName,
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addBankDesc,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancelBtn),
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
              child: Text(AppLocalizations.of(context)!.addBtn),
            ),
          ],
        );
      },
    );
  }
}
