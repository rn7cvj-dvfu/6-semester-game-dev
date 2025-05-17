import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../application/statistics_service.dart';
import '../bloc/statistics_bloc.dart';
import '../data/models/game_stats.dart';
import '../data/models/level_stat.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  // Helper to create the screen with its BLoC provider
  // This is useful for navigation
  static Widget blocProvider(BuildContext context) {
    // Ideally, StatisticsService comes from a proper DI setup (e.g., another provider, get_it)
    // For now, we instantiate it directly. This might not be suitable for a real app
    // if the service holds state or needs a longer lifecycle.
    final statisticsService = StatisticsService();

    return BlocProvider<StatisticsBloc>(
      create: (_) =>
          StatisticsBloc(statisticsService: statisticsService)
            ..add(const LoadStatistics()), // Load stats when BLoC is created
      child: const StatisticsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access translations using the recommended way by slang (usually via context extension or static getter)
    // Assuming `Translations.of(context)` is the correct way based on slang setup.
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.strings.statistics.title,
        ), // Access via t.strings.<namespace>.<key>
      ),
      body: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          if (state is StatisticsLoading || state is StatisticsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StatisticsLoaded) {
            final stats = state.stats;
            return _buildStatsContent(context, t, stats);
          } else if (state is StatisticsError) {
            return Center(
              child: Text('Error loading statistics: ${state.message}'),
            );
          } else {
            // Fallback for any other unhandled state
            return const Center(child: Text('An unknown error occurred.'));
          }
        },
      ),
    );
  }

  Widget _buildStatsContent(
    BuildContext context,
    Translations t,
    GameStats stats,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        // Allow pull-to-refresh to reload statistics
        context.read<StatisticsBloc>().add(const LoadStatistics());
      },
      child: ListView(
        padding: const EdgeInsets.all(16.0),
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
          const SizedBox(height: 12),
          _buildStatCard(
            context: context,
            title: t.strings.statistics.totalLevelsCompleted,
            value: stats.levelStats.length.toString(),
            icon: Icons.leaderboard_outlined,
          ),
          const SizedBox(height: 20),
          if (stats.levelStats.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                t.strings.statistics.levelsTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          stats.levelStats.isEmpty
              ? Center(
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
                          t.strings.statistics.noData,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                )
              : _buildLevelStatsList(context, t, stats.levelStats),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
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

  Widget _buildLevelStatsList(
    BuildContext context,
    Translations t,
    List<LevelStat> levelStats,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: levelStats.map((levelStat) {
        final levelDisplayName = t.strings.statistics.level(
          levelId: levelStat.levelId,
        );
        final timeFormatted = _formatDuration(
          Duration(milliseconds: levelStat.timeSpentMs),
        );
        return Card(
          elevation: 1.5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              child: Text(
                levelStat.levelId,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              levelDisplayName,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            trailing: Text(
              timeFormatted,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text(t.strings.statistics.timeSpent(time: timeFormatted)), // Alternative display
          ),
        );
      }).toList(),
    );
  }

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
    return '$seconds s';
  }
}
