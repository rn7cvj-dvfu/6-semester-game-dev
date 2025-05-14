import 'package:flutter/material.dart';

import '../features/ui/back_button.dart';
import '../navigation/navigator.dart';

class LevelsPage extends StatelessWidget {
  const LevelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: SizedBox(
                  width: 384,
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 16 + 16 + 16),
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      _LevelCard(
                        index: 0,
                        title: 'Демо Уровень',
                      ),
                      const SizedBox(height: 16),
                      _LevelCard(
                        index: 1,
                        title: 'Основы',
                      ),
                      const SizedBox(height: 16),
                      _LevelCard(
                        index: 2,
                        title: 'Первые алгоритмы',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GBackButton(
              onTap: AppNavigator.openHome,
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final String title;
  final int index;

  const _LevelCard({
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 384,
        child: InkWell(
          onTap: () => AppNavigator.openLevel(index),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
