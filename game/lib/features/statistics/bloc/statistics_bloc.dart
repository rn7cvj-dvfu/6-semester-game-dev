import 'dart:async'; // Added import for StreamSubscription

import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/statistics_service.dart';
import '../data/models/game_stats.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsService _statisticsService;
  StreamSubscription? _statsSubscription; // Changed to nullable

  StatisticsBloc({required StatisticsService statisticsService})
    : _statisticsService = statisticsService,
      super(const StatisticsInitial()) {
    on<LoadStatistics>(_onLoadStatistics);
    on<_InternalStatsUpdated>(
      _onInternalStatsUpdated,
    ); // Handler for internal event

    // Subscribe to stats updates from the service
    _statsSubscription = _statisticsService.statsStream.listen((gameStats) {
      if (!isClosed) {
        // Check if BLoC is closed before adding an event
        add(_InternalStatsUpdated(gameStats));
      }
    });
  }

  Future<void> _onLoadStatistics(
    LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(const StatisticsLoading());
    try {
      final stats = await _statisticsService.loadStats();
      emit(StatisticsLoaded(stats));
    } catch (e) {
      emit(StatisticsError(e.toString()));
    }
  }

  // Handler for stats updates received from StatisticsService stream
  void _onInternalStatsUpdated(
    _InternalStatsUpdated event,
    Emitter<StatisticsState> emit,
  ) {
    emit(StatisticsLoaded(event.stats));
  }

  @override
  Future<void> close() {
    _statsSubscription?.cancel(); // Cancel subscription when BLoC is closed
    return super.close();
  }
}
