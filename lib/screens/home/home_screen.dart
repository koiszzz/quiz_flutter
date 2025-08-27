import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: <Widget>[
          _buildMenuCard(
            context,
            AppLocalizations.of(context)!.bankManage,
            Icons.library_books,
            '/bank',
          ),
          _buildMenuCard(
            context,
            AppLocalizations.of(context)!.mode,
            Icons.assignment,
            '/quiz',
          ),
          _buildMenuCard(
            context,
            AppLocalizations.of(context)!.study,
            Icons.school,
            '/study',
          ),
          _buildMenuCard(
            context,
            AppLocalizations.of(context)!.stats,
            Icons.bar_chart,
            '/stats',
          ),
          _buildMenuCard(
            context,
            AppLocalizations.of(context)!.settings,
            Icons.settings,
            '/settings',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return Card(
      child: InkWell(
        onTap: () => context.go(route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 48.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8.0),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
