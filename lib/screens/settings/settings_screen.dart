import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            trailing: DropdownButton<String>(
              value: systemSettings['language'],
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(AppLocalizations.of(context)!.english),
                ),
                DropdownMenuItem(
                  value: 'zh',
                  child: Text(AppLocalizations.of(context)!.chinese),
                ),
              ],
              onChanged: (String? newLanguage) {
                if (newLanguage != null) {
                  ref.read(settingsProvider.notifier).setLanguage(newLanguage);
                }
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.themeModeLabel),
            trailing: DropdownButton<ThemeMode>(
              value: systemSettings['theme'],
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(AppLocalizations.of(context)!.themeModeSystem),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(AppLocalizations.of(context)!.themeModeLight),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(AppLocalizations.of(context)!.themeModeDark),
                ),
              ],
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  ref.read(settingsProvider.notifier).setThemeMode(newMode);
                }
              },
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.showAnswerInPracticeLabel,
            ),
            trailing: Switch(
              value: systemSettings['showAnswer'],
              onChanged: (value) {
                ref.read(settingsProvider.notifier).setShowAnswer(value);
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.importTemplateLabel),
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
          ListTile(
            title: Text(AppLocalizations.of(context)!.authorLabel),
            trailing: Text(AppLocalizations.of(context)!.authorName),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.projectAddressLabel),
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
