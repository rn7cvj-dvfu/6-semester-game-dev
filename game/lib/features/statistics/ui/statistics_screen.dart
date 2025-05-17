import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../.gen/i18n/strings.g.dart';
// import '../../../navigation/navigator.dart'; // No longer needed if using Navigator.of(context).pop()
import '../../settings.dart'; // For GSettings
import '../application/statistics_service.dart'; // Not directly used in build, but good for context
import '../bloc/statistics_bloc.dart';
import '../data/models/game_stats.dart';
// import '../data/models/level_stat.dart'; // No longer needed

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  // Helper to create the screen with its BLoC provider
  // This part remains the same as BlocProvider is now in App widget
  /* static Widget blocProvider(BuildContext context) {
    return BlocProvider<StatisticsBloc>(
      create: (_) =>
          StatisticsBloc(statisticsService: StatisticsService.instance)
            ..add(const LoadStatistics()), 
      child: const StatisticsScreen(),
    );
  } */

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Material(
      child: Center(
        child: SizedBox.square(
          dimension: GSettings.maxDialogWidth,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.strings.statistics.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(
                          context,
                        ).pop(), // Changed to Navigator.of(context).pop()
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<StatisticsBloc, StatisticsState>(
                      builder: (context, state) {
                        if (state is StatisticsLoading ||
                            state is StatisticsInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is StatisticsLoaded) {
                          final stats = state.stats;
                          return _buildStatsContentInsideCard(
                            context,
                            t,
                            stats,
                          );
                        }
                        if (state is StatisticsError) {
                          return Center(
                            child: Text(
                              // Using a generic error message as t.strings.common.error is missing
                              '${t.strings.statistics.title}: ${state.message}',
                            ),
                          );
                        }
                        return Center(
                          // Using a generic error message
                          child: Text(
                            t.strings.statistics.title +
                                ': ' +
                                t.strings.statistics.noData,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Renamed and adapted to fit inside the card's column
  Widget _buildStatsContentInsideCard(
    BuildContext context,
    Translations t,
    GameStats stats,
  ) {
    // Using ListView for scrollability within the Expanded widget
    return ListView(
      // padding: EdgeInsets.zero, // ListView has default padding, can be removed if needed
      children: <Widget>[
        _buildStatCard(
          context: context,
          title: t.strings.statistics.totalPlayTime,
          value: _formatDuration(
            Duration(milliseconds: stats.totalTimeInGameMs),
          ),
          icon: Icons.timer_outlined,
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          context: context,
          title: t.strings.statistics.sessionCount,
          value: stats.sessionCount.toString(),
          icon: Icons.repeat_one_outlined,
        ),
        // Removed totalLevelsCompleted card and level stats list
        /* const SizedBox(height: 12),
        _buildStatCard(
          context: context,
          title: t.strings.statistics.totalLevelsCompleted,
          value: stats.levelStats.length.toString(), // This would cause an error now
          icon: Icons.leaderboard_outlined,
        ),
        const SizedBox(height: 20),
        if (stats.levelStats.isNotEmpty) // This would cause an error now
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              t.strings.statistics.levelsTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        if (stats.levelStats.isEmpty) // This would cause an error now
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 48,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.strings.statistics.noData, // This specific noData might be for levels
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          )
        else
          _buildLevelStatsList(context, t, stats.levelStats), // This would cause an error now
        */
      ],
    );
  }

  // _buildStatCard remains the same as it returns a Card, which is fine.
  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 36, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Removed _buildLevelStatsList method
  /*
  Widget _buildLevelStatsList(
    BuildContext context,
    Translations t,
    List<LevelStat> levelStats,
  ) {
    // ... implementation was here ...
  }
  */

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    if (minutes > 0) {
      return '$minutes:${twoDigits(seconds)}';
    }
    // For seconds only, let's use the translation if available or just 's'
    // This part depends on how you want to localize/format 'seconds'
    // For simplicity, keeping 's'
    return '${seconds}s'; // t.strings.common.seconds(count: seconds) or similar
  }
}
