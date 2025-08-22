import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/models/question.dart';
import 'package:quiz_flutter/providers/quiz_provider.dart';
import 'package:quiz_flutter/screens/bank/add_edit_question_screen.dart';
import 'package:quiz_flutter/screens/bank/bank_screen.dart';
import 'package:quiz_flutter/screens/bank/question_list_screen.dart';
import 'package:quiz_flutter/screens/error/page_no_found_screen.dart';
import 'package:quiz_flutter/screens/home/home_screen.dart';
import 'package:quiz_flutter/screens/quiz/quiz_screen.dart';
import 'package:quiz_flutter/screens/quiz/quiz_taking_screen.dart';
import 'package:quiz_flutter/screens/settings/settings_screen.dart';
import 'package:quiz_flutter/screens/stats/stats_screen.dart';
import 'package:quiz_flutter/screens/study/study_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => const PageNoFoundScreen(),
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/bank',
      builder: (context, state) => const BankScreen(),
      routes: [
        GoRoute(
          path: ':bankId/questions',
          builder: (context, state) {
            final bankId = int.tryParse(state.pathParameters['bankId'] ?? '');
            return QuestionListScreen(bankId: bankId!);
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
      ],
    ),
    // GoRoute(
    //   path: '/bank/edit',
    //   builder: (context, state) {
    //     final bankId = state.uri.queryParameters['id'];
    //     return BankEditScreen(
    //       bankId: bankId == null ? null : int.parse(bankId),
    //     );
    //   },
    // ),
    GoRoute(path: '/quiz', builder: (context, state) => const QuizScreen()),
    GoRoute(
      path: '/quiz/taking/:mode/:bankId',
      builder: (context, state) {
        final bankId = int.tryParse(state.pathParameters['bankId'] ?? '');
        final mode = state.pathParameters['mode']!;
        final query = state.uri.queryParameters;

        final config = QuizConfig(
          bankId: bankId,
          mode: mode,
          single: int.tryParse(query['single'] ?? '0') ?? 0,
          multiple: int.tryParse(query['multiple'] ?? '0') ?? 0,
          trueFalse: int.tryParse(query['trueFalse'] ?? '0') ?? 0,
          duration: int.tryParse(query['duration'] ?? '0') ?? 0,
          shuffleQuestions: query['shuffleQuestions'] == 'true',
          shuffleOptions: query['shuffleOptions'] == 'true',
        );

        return QuizTakingScreen(config: config);
      },
    ),
    GoRoute(path: '/study', builder: (context, state) => const StudyScreen()),
    GoRoute(path: '/stats', builder: (context, state) => const StatsScreen()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
