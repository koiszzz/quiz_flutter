import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';

class PageNoFoundScreen extends ConsumerWidget {
  const PageNoFoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.pageNotFoundTitle)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: Text(AppLocalizations.of(context)!.backBtn),
        ),
      ),
    );
  }
}
