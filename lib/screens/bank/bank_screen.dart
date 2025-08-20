import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBankDialog(context),
        child: const Icon(Icons.add),
      ),
    );
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
