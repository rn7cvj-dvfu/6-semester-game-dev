import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../graph/models/model.dart';

part '../../../.gen/features/level/models/stage.freezed.dart';

@freezed
class LevelStageModel with _$LevelStageModel {
  const factory LevelStageModel.info({
    required String title,
    String? text,
    TextSpan? richText,
    required GraphModel graphModel,
  }) = _Info;

  const factory LevelStageModel.animation({
    required String title,
    String? text,
    TextSpan? richText,
    required GraphModel graphModel,
    // Each step is a map of nodeId to color
    required List<Map<String, Color>> animationSteps,
    @Default(Duration(milliseconds: 300)) Duration animationDurationMs,
  }) = _Animation;

  const factory LevelStageModel.question({
    required String title,
    String? text,
    TextSpan? richText,
    required GraphModel graphModel,
    required int correctAnswer,
    String? answerHint,
  }) = _Question;
}
