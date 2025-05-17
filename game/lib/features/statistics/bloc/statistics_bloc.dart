import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/statistics_service.dart';
import '../data/models/game_stats.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsService _statisticsService;

  StatisticsBloc({required StatisticsService statisticsService})
    : _statisticsService = statisticsService,
      super(const StatisticsInitial()) {
    on<LoadStatistics>(_onLoadStatistics);
    on<IncrementSession>(_onIncrementSession);
    on<AddPlayTime>(_onAddPlayTime);
    on<RecordLevelTime>(_onRecordLevelTime);
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

  Future<void> _onIncrementSession(
    IncrementSession event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      await _statisticsService.incrementSessionCount();
      // Reload stats to reflect the change, or update in-memory state if preferred
      final stats = await _statisticsService.loadStats();
      emit(StatisticsLoaded(stats));
    } catch (e) {
      emit(StatisticsError(e.toString()));
    }
  }

  Future<void> _onAddPlayTime(
    AddPlayTime event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      await _statisticsService.addTotalGameTime(event.duration);
      final stats = await _statisticsService.loadStats();
      emit(StatisticsLoaded(stats));
    } catch (e) {
      emit(StatisticsError(e.toString()));
    }
  }

  Future<void> _onRecordLevelTime(
    RecordLevelTime event,
    Emitter<StatisticsState> emit,
  ) async {
    try {
      await _statisticsService.recordLevelTime(event.levelId, event.timeSpent);
      final stats = await _statisticsService.loadStats();
      emit(StatisticsLoaded(stats));
    } catch (e) {
      emit(StatisticsError(e.toString()));
    }
  }
}
