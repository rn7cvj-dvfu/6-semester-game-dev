part of 'statistics_bloc.dart';

// Note: @freezed annotation and generated part for this file
// will be handled in statistics_bloc.dart when using this pattern.
// However, for standalone freezed classes not part of a bloc library file,
// you'd include:
// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'statistics_event.freezed.dart';

// For BLoC, events are typically part of the BLoC library.
// The @freezed and its part file will be in statistics_bloc.dart.
// This file will define the abstract class/sealed class for events.

sealed class StatisticsEvent {
  const StatisticsEvent();
}

class LoadStatistics extends StatisticsEvent {
  const LoadStatistics();
}

class IncrementSession extends StatisticsEvent {
  const IncrementSession();
}

class AddPlayTime extends StatisticsEvent {
  const AddPlayTime({required this.duration});
  final Duration duration;
}

class RecordLevelTime extends StatisticsEvent {
  const RecordLevelTime({required this.levelId, required this.timeSpent});
  final String levelId;
  final Duration timeSpent;
}
