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
  final String infoTitle;
  final String infoText;
  final GraphModel graphModel;

  _SubStage({
    required this.infoTitle,
    required this.infoText,
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

  late final List<_SubStage> _stages = [
    _SubStage(
      infoTitle: context.t.strings.levels.k2.stages.k1.title,
      infoText: context.t.strings.levels.k2.stages.k1.text,
      graphModel: GraphModel.fromAdjacencyMatrix([
        [0, 1, 1, 0],
        [1, 0, 0, 1],
        [1, 0, 0, 1],
        [0, 1, 1, 0],
      ]),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k2.stages.k2.title,
      infoText: context.t.strings.levels.k2.stages.k2.text,
      graphModel: GraphModel.fromAdjacencyMatrix([
        [0, 1, 0, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 1],
        [0, 0, 1, 0],
      ]),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k2.stages.k3.title,
      infoText: context.t.strings.levels.k2.stages.k3.text,
      graphModel: GraphModel.fromAdjacencyMatrix([
        [0, 1, 0, 0, 0],
        [1, 0, 0, 0, 0],
        [0, 0, 0, 1, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0],
      ]),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k2.stages.k4.title,
      infoText: context.t.strings.levels.k2.stages.k4.text,
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
              title: currentStageData.infoTitle,
              text: currentStageData.infoText,
              initialStageIndex: _currentStageIndex,
              totalStages: _stages.length,
              onStageChanged: (stageIndex) => setState(() {
                _currentStageIndex = stageIndex;
                setState(() {});
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
