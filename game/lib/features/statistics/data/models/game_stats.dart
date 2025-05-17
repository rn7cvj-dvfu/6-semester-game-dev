import 'package:freezed_annotation/freezed_annotation.dart';
import 'level_stat.dart';

part '../../../../.gen/features/statistics/data/models/game_stats.freezed.dart';
part '../../../../.gen/features/statistics/data/models/game_stats.g.dart';

@freezed
class GameStats with _$GameStats {
  const factory GameStats({
    required int totalTimeInGameMs,
    required int sessionCount,
    required List<LevelStat> levelStats,
  }) = _GameStats;

  factory GameStats.empty() =>
      const GameStats(totalTimeInGameMs: 0, sessionCount: 0, levelStats: []);

  factory GameStats.fromJson(Map<String, dynamic> json) =>
      _$GameStatsFromJson(json);
}
