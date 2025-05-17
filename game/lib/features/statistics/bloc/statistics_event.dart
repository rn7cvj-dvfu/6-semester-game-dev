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

abstract class StatisticsEvent {
  const StatisticsEvent();
}

class LoadStatistics extends StatisticsEvent {
  const LoadStatistics();
}

// IncrementSession is now handled by StatisticsService.init()
// class IncrementSession extends StatisticsEvent {}

// AddPlayTime is now handled by StatisticsService play time tracking methods
// class AddPlayTime extends StatisticsEvent {
//   final Duration duration;
//   AddPlayTime(this.duration);
// }

// Internal event for BLoC to react to service updates
class _InternalStatsUpdated extends StatisticsEvent {
  final GameStats stats;
  const _InternalStatsUpdated(this.stats);
}

// Optional: Event to explicitly save pending play time if needed from UI/Bloc trigger
// class FlushPlayTime extends StatisticsEvent {}

// Optional: Event to refresh stats from service if there's no immediate feedback loop
// class RefreshStatistics extends StatisticsEvent {}
