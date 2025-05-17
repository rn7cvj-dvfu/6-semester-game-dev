import 'dart:async';

import 'package:flutter/material.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../application/statistics_service.dart';
import '../data/game_stats.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateStats();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateStats();
    });
  }

  void _updateStats() {
    StatisticsService.instance.emitCurrentLiveStats();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final stats = StatisticsService.instance.statsStream;

    return Card(
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Spacer(),
            StreamBuilder<GameStats>(
              stream: stats,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.data != null) {
                  return _StatsContent(t: t, stats: asyncSnapshot.data!);
                } else if (asyncSnapshot.hasError) {
                  return Text('Error: ${asyncSnapshot.error}');
                }
                return LinearProgressIndicator();
              },
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: StatisticsService.instance.resetStats,
                child: Text(t.strings.statistics.reset),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class _StatsContent extends StatelessWidget {
  const _StatsContent({required this.t, required this.stats});

  final Translations t;
  final GameStats stats;

  // Method to format duration, moved here as it's specific to this widget's content
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
    return '${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        _StatCard(
          title: t.strings.statistics.totalPlayTime,
          value: _formatDuration(
            Duration(milliseconds: stats.totalTimeInGameMs),
          ),
          icon: Icons.timer_outlined,
        ),
        const SizedBox(height: 12),
        _StatCard(
          title: t.strings.statistics.sessionCount,
          value: stats.sessionCount.toString(),
          icon: Icons.repeat_one_outlined,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
}
