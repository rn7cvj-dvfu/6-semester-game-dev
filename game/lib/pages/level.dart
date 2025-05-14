import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../features/graph/game.dart';

class LevelPage extends StatelessWidget {
  final int levelId;

  const LevelPage({super.key, required this.levelId});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GameWidget(
        game: GraphGame(
          backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
          dotColorValue: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
