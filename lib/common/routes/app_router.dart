import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/screens/bank/add_edit_question_screen.dart';
import 'package:quiz_flutter/screens/bank/bank_screen.dart';
import 'package:quiz_flutter/screens/bank/question_list_screen.dart';
import 'package:quiz_flutter/screens/error/page_no_found_screen.dart';
import 'package:quiz_flutter/screens/home/home_screen.dart';
import 'package:quiz_flutter/screens/quiz/quiz_screen.dart';
import 'package:quiz_flutter/screens/quiz/quiz_taking_screen.dart';
import 'package:quiz_flutter/screens/settings/settings_screen.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/screens/stats/stats_screen.dart';
import 'package:quiz_flutter/screens/study/study_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'bank',
          builder: (context, state) => const BankScreen(),
          routes: [
            GoRoute(
              path: ':bankId/questions',
              builder: (context, state) {
                final bankId = int.parse(state.pathParameters['bankId']!);
                return QuestionListScreen(bankId: bankId);
              },
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) {
                    final bankId = int.parse(state.pathParameters['bankId']!);
                    return AddEditQuestionScreen(bankId: bankId);
                  },
                ),
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final question = state.extra as Question;
                    return AddEditQuestionScreen(
                      question: question,
                      bankId: question.bankId,
                    );
                  },
                ),
              ],
            ),

            // ],
            // ),
          ],
        ),
        GoRoute(
          path: 'quiz',
          builder: (context, state) => const QuizScreen(),
          routes: [
            GoRoute(
              path: 'taking/:mode/:bankId',
              builder: (context, state) {
                final bankId = int.parse(state.pathParameters['bankId']!);
                final mode = state.pathParameters['mode'] as String;
                return QuizTakingScreen(bankId: bankId, mode: mode);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'study',
          builder: (context, state) => const StudyScreen(),
        ),
        GoRoute(
          path: 'stats',
          builder: (context, state) => const StatsScreen(),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const PageNoFoundScreen(),
);
