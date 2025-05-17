import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../.gen/features/statistics/data/models/level_stat.freezed.dart';
part '../../../../.gen/features/statistics/data/models/level_stat.g.dart';

@freezed
class LevelStat with _$LevelStat {
  const factory LevelStat({
    required String levelId,
    required int timeSpentMs,
    // If you have sub-stages, you can add a map here:
    // Map<String, int> subStageTimesMs,
  }) = _LevelStat;

  factory LevelStat.fromJson(Map<String, dynamic> json) =>
      _$LevelStatFromJson(json);
}
