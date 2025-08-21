import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_flutter/common/routes/app_router.dart';
import 'package:quiz_flutter/providers/settings_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the settingsProvider to get the current themeMode.
    final systemSettings = ref.watch(settingsProvider);

    return MaterialApp.router(
      title: 'Quiz App',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          error: Colors.deepOrangeAccent[400],
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purpleAccent,
          brightness: Brightness.dark,
          error: Colors.orangeAccent[400],
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        useMaterial3: true,
      ),
      themeMode: systemSettings['theme'],
      routerConfig: router,
    );
  }
}
