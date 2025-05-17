import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/game_stats.dart';
import '../data/models/level_stat.dart';

class StatisticsService {
  static const String _statsKey = 'game_stats';

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<GameStats> loadStats() async {
    final prefs = await _prefs;
    final String? statsJson = prefs.getString(_statsKey);
    if (statsJson != null) {
      try {
        return GameStats.fromJson(
          jsonDecode(statsJson) as Map<String, dynamic>,
        );
      } catch (e) {
        // If decoding fails, return empty stats
        return GameStats.empty();
      }
    }
    return GameStats.empty();
  }

  Future<void> saveStats(GameStats stats) async {
    final prefs = await _prefs;
    await prefs.setString(_statsKey, jsonEncode(stats.toJson()));
  }

  Future<void> incrementSessionCount() async {
    final stats = await loadStats();
    final updatedStats = stats.copyWith(sessionCount: stats.sessionCount + 1);
    await saveStats(updatedStats);
  }

  Future<void> addTotalGameTime(Duration duration) async {
    final stats = await loadStats();
    final updatedStats = stats.copyWith(
      totalTimeInGameMs: stats.totalTimeInGameMs + duration.inMilliseconds,
    );
    await saveStats(updatedStats);
  }

  Future<void> recordLevelTime(String levelId, Duration timeSpent) async {
    final stats = await loadStats();
    final List<LevelStat> updatedLevelStats = List.from(stats.levelStats);

    final existingLevelIndex = updatedLevelStats.indexWhere(
      (ls) => ls.levelId == levelId,
    );

    if (existingLevelIndex != -1) {
      // For simplicity, we overwrite the time.
      // Alternatively, one might want to average or sum times if levels can be replayed.
      // For now, we'll just store the latest time. Or perhaps the best time?
      // Let's assume we store the most recent time for now.
      final existingStat = updatedLevelStats[existingLevelIndex];
      updatedLevelStats[existingLevelIndex] = existingStat.copyWith(
        timeSpentMs: timeSpent.inMilliseconds,
      );
    } else {
      updatedLevelStats.add(
        LevelStat(levelId: levelId, timeSpentMs: timeSpent.inMilliseconds),
      );
    }

    final updatedStats = stats.copyWith(levelStats: updatedLevelStats);
    await saveStats(updatedStats);
  }

  // Call this when the game/app starts
  Future<void> onAppStart() async {
    await incrementSessionCount();
    // You might want to start a timer for total game time here
    // or handle it differently based on app lifecycle.
  }

  // Example: Call this when a level is completed
  // Future<void> onLevelComplete(String levelId, Duration timeTaken) async {
  //   await recordLevelTime(levelId, timeTaken);
  // }

  // Placeholder for sub-stage time recording if needed later
  // Future<void> recordSubStageTime(String levelId, String subStageId, Duration timeSpent) async {
  //   final stats = await loadStats();
  //   // Logic to find the level and update/add sub-stage time
  //   // ...
  //   await saveStats(stats);
  // }
}
