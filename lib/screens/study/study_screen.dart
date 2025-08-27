import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(AppLocalizations.of(context)!.study),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStudyCard(
            context,
            AppLocalizations.of(context)!.quizReviewTitle,
            AppLocalizations.of(context)!.reviewWrongQuestions,
            Icons.assignment_late,
            () {
              context.go(
                '/quiz/taking/wrong/0?single=10&multiple=5&trueFalse=5&duration=&shuffleQuestions=false&shuffleOptions=false',
              );
            },
          ),
          _buildStudyCard(
            context,
            AppLocalizations.of(context)!.favorite,
            AppLocalizations.of(context)!.favoriteReviewMsg,
            Icons.favorite,
            () {
              context.go(
                '/quiz/taking/favorites/0?single=10&multiple=5&trueFalse=5&duration=&shuffleQuestions=false&shuffleOptions=false',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStudyCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).iconTheme.color),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
