import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/providers/settings_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemSettings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('设置'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('主题模式'),
            trailing: DropdownButton<ThemeMode>(
              value: systemSettings['theme'],
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('跟随系统')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('亮色模式')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('暗色模式')),
              ],
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  ref.read(settingsProvider.notifier).setThemeMode(newMode);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('练习模式是否显示答案'),
            trailing: Switch(
              value: systemSettings['showAnswer'],
              onChanged: (value) {
                ref.read(settingsProvider.notifier).setShowAnswer(value);
              },
            ),
          ),
          ListTile(
            title: const Text('导入模板链接'),
            trailing: IconButton(
              icon: const Icon(Icons.link),
              onPressed: () {
                launchUrl(
                  Uri.parse(
                    'https://raw.githubusercontent.com/koiszzz/quiz_flutter/refs/heads/main/proto/template.xlsx',
                  ),
                );
              },
            ),
          ),
          ListTile(title: const Text('作者'), trailing: Text('koiszzz')),
          ListTile(
            title: const Text('项目地址'),
            trailing: IconButton(
              icon: const Icon(Icons.link),
              onPressed: () {
                launchUrl(Uri.parse('https://github.com/koiszzz/quiz_flutter'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
