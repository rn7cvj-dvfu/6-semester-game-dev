part of 'statistics_bloc.dart';

// Import for GameStats will be in statistics_bloc.dart
// Similar to events, the @freezed and its part file for states
// will be in statistics_bloc.dart if using Freezed for states.

sealed class StatisticsState {
  const StatisticsState();
}

class StatisticsInitial extends StatisticsState {
  const StatisticsInitial();
}

class StatisticsLoading extends StatisticsState {
  const StatisticsLoading();
}

class StatisticsLoaded extends StatisticsState {
  final GameStats
  stats; // GameStats type will be resolved from statistics_bloc.dart
  const StatisticsLoaded(this.stats);
}

class StatisticsError extends StatisticsState {
  final String message;
  const StatisticsError(this.message);
}
