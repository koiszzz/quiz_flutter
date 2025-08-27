import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  static const String _themeKey = 'theme_mode';
  static const String _showAnswerKey = 'show_answer';
  static const String _languageKey = 'language';

  @override
  Map<String, dynamic> build() {
    _loadData();
    // Return the initial state synchronously
    return {'theme': ThemeMode.system, 'showAnswer': false, 'language': 'en'};
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
    final showAnswer = prefs.getBool(_showAnswerKey) ?? false;
    final language =
        prefs.getString(_languageKey) ??
        (Platform.localeName.startsWith('zh') ? 'zh' : 'en');
    state = {
      'theme': ThemeMode.values[themeIndex],
      'showAnswer': showAnswer,
      'language': language,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = {
      'theme': mode,
      'showAnswer': state['showAnswer'],
      'language': state['language'],
    };
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setShowAnswer(bool show) async {
    state = {
      'theme': state['theme'],
      'showAnswer': show,
      'language': state['language'],
    };
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showAnswerKey, show);
  }

  Future<void> setLanguage(String newLanguage) async {
    state = {
      'theme': state['theme'],
      'showAnswer': state['showAnswer'],
      'language': newLanguage,
    };
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, newLanguage);
  }
}
