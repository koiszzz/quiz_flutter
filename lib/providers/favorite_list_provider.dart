import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:quiz_flutter/services/database_helper.dart';

import '../models/models.dart';

part 'favorite_list_provider.g.dart';

@Riverpod(keepAlive: true)
class FavoriteList extends _$FavoriteList {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  Future<List<int>> build() async {
    final favorites = await _dbHelper.getAllFavorites();
    return favorites.map((f) => f.questionId).toList();
  }

  bool isFavorite(int questionId) {
    return state.value?.contains(questionId) ?? false;
  }

  Future<void> toggleFavorite(int questionId) async {
    if (isFavorite(questionId)) {
      await _dbHelper.deleteFavorite(questionId);
    } else {
      await _dbHelper.insertFavorite(Favorite(questionId: questionId));
    }
    ref.invalidateSelf();
    await future;
  }
}
