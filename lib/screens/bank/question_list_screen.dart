import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/providers/bank_list_provider.dart';
import 'package:quiz_flutter/providers/question_list_provider.dart';

class QuestionListScreen extends ConsumerWidget {
  final int bankId;

  const QuestionListScreen({super.key, required this.bankId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Question>> questionList = ref.watch(
      questionListProvider(bankId),
    );
    final AsyncValue<QuestionBank> bank = ref
        .watch(bankListProvider)
        .whenData((value) => value.firstWhere((b) => b.id == bankId));
    return Scaffold(
      appBar: AppBar(
        title: switch (bank) {
          AsyncData(:final value) => Text(value.name),
          _ => Text(AppLocalizations.of(context)!.questionBankTitle),
        },
        // Add a back button to navigate to the bank list
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/bank'),
        ),
      ),
      body: switch (questionList) {
        AsyncData(:final value) =>
          value.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noQuestionMsg))
              : ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final question = value[index];
                    return ListTile(
                      title: Text(question.content),
                      subtitle: Text(
                        '${AppLocalizations.of(context)!.questionType}: ${AppLocalizations.of(context)!.typeLabel(question.type)}',
                      ),
                      // Use relative navigation for the edit route
                      onTap: () => context.go(
                        '/bank/${question.bankId}/questions/edit',
                        extra: question,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await ref
                              .read(
                                questionListProvider(question.bankId).notifier,
                              )
                              .deleteQuestion(question.id!);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.questionRemovedMsg,
                                  ),
                                ),
                              );
                          }
                        },
                      ),
                    );
                  },
                ),
        AsyncError() => Center(
          child: Text(AppLocalizations.of(context)!.unexpectedErrorMsg),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: FloatingActionButton(
        // Use relative navigation for the add route
        onPressed: () => context.go('/bank/${bank.value?.id}/questions/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
