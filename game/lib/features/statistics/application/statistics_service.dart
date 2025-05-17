import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/game_stats.dart';

class StatisticsService {
  static const String _statsKey = 'game_stats';
  static StatisticsService? _instance;

  final StreamController<GameStats> _statsStreamController =
      StreamController<GameStats>.broadcast();

  Stream<GameStats> get statsStream => _statsStreamController.stream;

  StatisticsService._();

  static StatisticsService get instance {
    if (_instance == null) {
      throw StateError(
        'StatisticsService not initialized. Call StatisticsService.init() first.',
      );
    }
    return _instance!;
  }

  static Future<void> init() async {
    if (_instance == null) {
      _instance = StatisticsService._();
      await _instance!._onAppStart();
    }
  }

  final Stopwatch _playTimeStopwatch = Stopwatch();

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
        return GameStats.empty();
      }
    }
    return GameStats.empty();
  }

  Future<void> _saveStats(GameStats stats) async {
    final prefs = await _prefs;
    await prefs.setString(_statsKey, jsonEncode(stats.toJson()));
    if (!_statsStreamController.isClosed) {
      _statsStreamController.add(stats);
    }
  }

  Future<void> _onAppStart() async {
    final initialStats = await loadStats();
    if (!_statsStreamController.isClosed) {
      _statsStreamController.add(initialStats);
    }
    await _incrementSessionCount();
    startPlayTimeTracking();
  }

  Future<void> _incrementSessionCount() async {
    final stats = await loadStats();
    final updatedStats = stats.copyWith(sessionCount: stats.sessionCount + 1);
    await _saveStats(updatedStats);
  }

  Future<void> _addTotalGameTime(Duration duration) async {
    if (duration.inMilliseconds <= 0) return;
    final stats = await loadStats();
    final updatedStats = stats.copyWith(
      totalTimeInGameMs: stats.totalTimeInGameMs + duration.inMilliseconds,
    );
    await _saveStats(updatedStats);
  }

  void startPlayTimeTracking() {
    if (!_playTimeStopwatch.isRunning) {
      _playTimeStopwatch.start();
    }
  }

  void stopPlayTimeTracking() {
    if (_playTimeStopwatch.isRunning) {
      _playTimeStopwatch.stop();
      _saveCurrentPlayTime();
    }
  }

  Future<void> _saveCurrentPlayTime() async {
    final elapsed = _playTimeStopwatch.elapsed;
    if (elapsed.inMilliseconds > 0) {
      await _addTotalGameTime(elapsed);
      _playTimeStopwatch.reset();
    }
  }

  Future<void> onAppDispose() async {
    stopPlayTimeTracking();
  }

  Future<void> resetStats() async {
    final emptyStats = GameStats.empty();
    _playTimeStopwatch.reset();
    await _saveStats(emptyStats);
  }

  Future<void> emitCurrentLiveStats() async {
    if (_statsStreamController.isClosed) return;

    final persistentStats = await loadStats();
    final liveElapsedMs = _playTimeStopwatch.elapsedMilliseconds;

    final liveStats = persistentStats.copyWith(
      totalTimeInGameMs: persistentStats.totalTimeInGameMs + liveElapsedMs,
    );
    _statsStreamController.add(liveStats);
  }

  void dispose() {
    _statsStreamController.close();
  }
}
