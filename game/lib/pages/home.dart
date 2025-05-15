import 'package:flutter/material.dart';

import '../navigation/navigator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NavigationButton(
              icon: Icons.leaderboard_rounded,
              size: 48,
              onTap: AppNavigator.openStatistic,
            ),
            SizedBox(width: 16),
            _NavigationButton(
              icon: Icons.play_arrow_rounded,
              size: 64,
              onTap: AppNavigator.openLevels,
            ),
            SizedBox(width: 16),
            _NavigationButton(
              icon: Icons.settings_rounded,
              size: 48,
              onTap: AppNavigator.openSettings,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _NavigationButton({
    required this.icon,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            icon,
            size: size,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
