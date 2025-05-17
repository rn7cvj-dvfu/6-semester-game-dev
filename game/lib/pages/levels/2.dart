import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/levels/2/level_info.dart';
import '../../features/levels/finish_level_dialog.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class _SubStage {
  final String title;
  final String? text;
  final TextSpan? richText;
  final GraphModel graphModel;

  _SubStage({
    required this.title,
    this.text,
    this.richText,
    required this.graphModel,
  });
}

class SecondLevelPage extends StatefulWidget {
  const SecondLevelPage({super.key});

  @override
  State<SecondLevelPage> createState() => _SecondLevelPageState();
}

class _SecondLevelPageState extends State<SecondLevelPage> {
  int _currentStageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late final List<_SubStage> _stages = [
    _SubStage(
      title: context.t.strings.levels.k2.stages.k1.title,
      richText: context.t.strings.levels.k2.stages.k1.richText(
        redNode: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
        greenNode: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.green),
        ),
        blueNode: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
        ),
      ),
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 1, 0],
          [1, 0, 0, 1],
          [1, 0, 0, 1],
          [0, 1, 1, 0],
        ],
        nodeColor: (nodeIndex) => switch (nodeIndex) {
          0 => Colors.blue,
          1 => Colors.red,
          2 => Colors.green,
          _ => null,
        },
      ),
    ),
    _SubStage(
      title: context.t.strings.levels.k2.stages.k2.title,
      richText: context.t.strings.levels.k2.stages.k2.richText(
        redNode: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
        blueNode: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
        ),
      ),
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 0, 0],
          [1, 0, 0, 0],
          [0, 0, 0, 1],
          [0, 0, 1, 0],
        ],
        nodeColor: (nodeIndex) => switch (nodeIndex) {
          1 => Colors.red,
          2 => Colors.blue,
          _ => null,
        },
      ),
    ),
    _SubStage(
      title: context.t.strings.levels.k2.stages.k3.title,
      text: context.t.strings.levels.k2.stages.k3.text,
      graphModel: GraphModel.fromAdjacencyMatrix([
        [0, 1, 0, 0, 0],
        [1, 0, 0, 0, 0],
        [0, 0, 0, 1, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0],
      ]),
    ),
    _SubStage(
      title: context.t.strings.levels.k2.stages.k4.title,
      text: context.t.strings.levels.k2.stages.k4.text,
      graphModel: GraphModel.fromAdjacencyMatrix([
        [0, 1, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
      ]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentStageData = _stages[_currentStageIndex];
    const transitionDuration = Duration(milliseconds: 500);

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: transitionDuration,
              reverseDuration: transitionDuration,
              child: GameWidget(
                key: ValueKey(_currentStageIndex),
                game: GraphWidget(
                  graphModel: currentStageData.graphModel,
                  backgroundColorValue: Theme.of(
                    context,
                  ).scaffoldBackgroundColor,
                  nodeColorValue: Theme.of(context).colorScheme.primary,
                  edgeColorValue: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  onNodeClick: (nodeId) {},
                  onEdgeClick: (edgeId) {},
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GBackButton(onTap: AppNavigator.openLevels),
          ),
          Positioned(
            top: 0,
            right: 16,
            bottom: 0,
            child: SecondLevelInfo(
              title: currentStageData.title,
              text: currentStageData.text,
              richText: currentStageData.richText,
              initialStageIndex: _currentStageIndex,
              totalStages: _stages.length,
              onStageChanged: (stageIndex) => setState(() {
                _currentStageIndex = stageIndex;
              }),
              onComplete: () {
                showFinishLevelDialog(context, 3);
              },
            ),
          ),
        ],
      ),
    );
  }
}
