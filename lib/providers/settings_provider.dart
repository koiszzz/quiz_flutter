import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  static const String _themeKey = 'theme_mode';
  static const String _showAnswerKey = 'show_answer';

  @override
  Map<String, dynamic> build() {
    _loadData();
    // Return the initial state synchronously
    return {'theme': ThemeMode.system, 'showAnswer': false};
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
    final showAnswer = prefs.getBool(_showAnswerKey) ?? false;
    state = {'theme': ThemeMode.values[themeIndex], 'showAnswer': showAnswer};
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = {'theme': mode, 'showAnswer': state['showAnswer']};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setShowAnswer(bool show) async {
    state = {'theme': state['theme'], 'showAnswer': show};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showAnswerKey, show);
  }
}
