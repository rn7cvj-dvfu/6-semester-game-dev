import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/game_stats.dart';
// import '../data/models/level_stat.dart'; // No longer needed

class StatisticsService {
  static const String _statsKey = 'game_stats';
  static StatisticsService? _instance;

  // Stream controller to broadcast stats changes
  // Make it broadcast if multiple listeners might exist, though for Bloc it's usually one.
  // For simplicity, a single-subscription controller is also fine if only Bloc listens directly.
  final StreamController<GameStats> _statsStreamController =
      StreamController<GameStats>.broadcast();

  // Public stream for BLoC or other parts of the app to listen to
  Stream<GameStats> get statsStream => _statsStreamController.stream;

  // Private constructor
  StatisticsService._();

  // Static instance getter
  static StatisticsService get instance {
    if (_instance == null) {
      throw StateError(
        'StatisticsService not initialized. Call StatisticsService.init() first.',
      );
    }
    return _instance!;
  }

  // Initialization method
  static Future<void> init() async {
    if (_instance == null) {
      _instance = StatisticsService._();
      await _instance!._onAppStart();
    }
  }

  Stopwatch _playTimeStopwatch = Stopwatch();
  Timer? _periodicSaveTimer;

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
        if (kDebugMode) {
          print('Error decoding stats: $e. Returning empty stats.');
        }
        // If decoding fails, return empty stats
        return GameStats.empty();
      }
    }
    return GameStats.empty();
  }

  Future<void> saveStats(GameStats stats) async {
    final prefs = await _prefs;
    await prefs.setString(_statsKey, jsonEncode(stats.toJson()));
    // Notify listeners about the updated stats
    if (!_statsStreamController.isClosed) {
      _statsStreamController.add(stats);
    }
  }

  // Made private and renamed as it's called by init
  Future<void> _onAppStart() async {
    await _incrementSessionCount();
    startPlayTimeTracking(); // Start tracking time when app starts
    _periodicSaveTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _saveCurrentPlayTime(); // This will save elapsed time and reset the stopwatch.
      // If the app is still supposed to be tracking time (i.e., this timer is firing),
      // we should restart the stopwatch for the next interval.
      // The startPlayTimeTracking method is idempotent and will handle if it's already running,
      // but after a reset, it needs to be explicitly started.
      startPlayTimeTracking();
    });
  }

  Future<void> _incrementSessionCount() async {
    final stats = await loadStats();
    final updatedStats = stats.copyWith(sessionCount: stats.sessionCount + 1);
    await saveStats(updatedStats);
  }

  Future<void> _addTotalGameTime(Duration duration) async {
    if (duration.inMilliseconds <= 0) return; // Don't save if no time passed
    final stats = await loadStats();
    final updatedStats = stats.copyWith(
      totalTimeInGameMs: stats.totalTimeInGameMs + duration.inMilliseconds,
    );
    await saveStats(updatedStats);
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
      // Reset stopwatch after saving to avoid double counting if called multiple times
      _playTimeStopwatch.reset();
      // We don't restart it here, startPlayTimeTracking will handle it on resume
    }
  }

  // Call this when the app is shutting down or going to background permanently
  Future<void> onAppDispose() async {
    stopPlayTimeTracking(); // Save any pending play time
    _periodicSaveTimer?.cancel(); // Cancel the periodic save timer
  }

  // Call this to clean up resources, e.g. when the app is truly closing
  // or if the service were to be disposed (not typical for a singleton like this).
  void dispose() {
    _statsStreamController.close();
    _periodicSaveTimer?.cancel(); // Ensure timer is cancelled here too
  }

  // Removed recordLevelTime method
  /*
  Future<void> recordLevelTime(String levelId, Duration timeSpent) async {
    final stats = await loadStats();
    // ... logic for levelStats was here ...
    await saveStats(updatedStats);
  }
  */
}

// No longer need public onAppStart, addTotalGameTime, incrementSessionCount
// as they are handled internally or via play time tracking methods.
// Public API now is:
// StatisticsService.init()
// StatisticsService.instance.loadStats()
// StatisticsService.instance.startPlayTimeTracking() // e.g. on resume
// StatisticsService.instance.stopPlayTimeTracking()  // e.g. on pause
// StatisticsService.instance.onAppDispose() // e.g. on app close
// The BLoC will use these.
// Note: Changed recordLevelTime to store the *best* time (shortest).
