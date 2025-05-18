import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/bloc/placement.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/levels/3/level_info.dart';
import '../../features/levels/finish_level_dialog.dart';
import '../../features/settings.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class _SubStage {
  final String title;

  final TextSpan? richText;
  final GraphModel graphModel;

  _SubStage({required this.title, this.richText, required this.graphModel});
}

class FourthLevelPage extends StatefulWidget {
  const FourthLevelPage({super.key});

  @override
  State<FourthLevelPage> createState() => _FourthLevelPageState();
}

class _FourthLevelPageState extends State<FourthLevelPage> {
  int _currentStageIndex = 0;

  late final List<_SubStage> _stages = [
    _SubStage(
      title: context.t.strings.levels.k4.stages.k1.title,
      richText: context.t.strings.levels.k4.stages.k1.richText(
        redNode: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
        blue: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
        ),
      ),
      graphModel: GraphModel(
        nodes: [
          NodeModel(id: 'A', preferredColor: Colors.red),
          NodeModel(id: 'B'),
          NodeModel(id: 'C'),
          NodeModel(id: 'D', preferredColor: Colors.blue),
        ],
        edges: [
          EdgeModel(id: 'A-B', firstNodeId: 'A', secondNodeId: 'B'),
          EdgeModel(id: 'B-C', firstNodeId: 'B', secondNodeId: 'C'),

          EdgeModel(id: 'C-D', firstNodeId: 'C', secondNodeId: 'D'),
        ],
        clickable: false,
        movable: false,
      ),
    ),
    _SubStage(
      title: context.t.strings.levels.k4.stages.k2.title,
      richText: context.t.strings.levels.k4.stages.k2.richText(
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
      graphModel: GraphModel(
        nodes: [
          NodeModel(id: 'A', preferredColor: Colors.red),
          NodeModel(id: 'B', preferredColor: Colors.blue),
          NodeModel(id: 'C'),
        ],
        edges: [
          EdgeModel(id: 'A-B', firstNodeId: 'A', secondNodeId: 'B'),
          EdgeModel(id: 'B-C', firstNodeId: 'B', secondNodeId: 'C'),
        ],
        clickable: false,
        movable: false,
      ),
    ),
    _SubStage(
      title: context.t.strings.levels.k4.stages.k3.title,
      richText: context.t.strings.levels.k4.stages.k3.richText(
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
      graphModel: GraphModel(
        placement: GraphNodesPlacement.random(seed: 69),
        nodes: [
          NodeModel(id: 'A', preferredColor: Colors.red),
          NodeModel(id: 'B'),
          NodeModel(id: 'C'),
          NodeModel(id: 'D'),
          NodeModel(id: 'E'),
          NodeModel(
            id: 'F',
            preferredColor: Colors.blue,
            preferredPosition: (0, 0),
          ),
        ],
        edges: [
          EdgeModel(id: 'A-B', firstNodeId: 'A', secondNodeId: 'B'),
          EdgeModel(id: 'B-C', firstNodeId: 'B', secondNodeId: 'C'),
          EdgeModel(id: 'C-D', firstNodeId: 'C', secondNodeId: 'D'),
          EdgeModel(id: 'D-E', firstNodeId: 'D', secondNodeId: 'E'),
          EdgeModel(id: 'E-F', firstNodeId: 'E', secondNodeId: 'F'),
        ],
        clickable: false,
        movable: false,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentStage = _stages[_currentStageIndex];
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16 + 64,
                right: GSettings.maxDialogWidth + 16 + 16,
                bottom: 16,
                left: 16,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                child: GameWidget(
                  key: ValueKey(_currentStageIndex),
                  game: GraphWidget(
                    graphModel: currentStage.graphModel,
                    onNodeClick: (_) {},
                    onEdgeClick: (_) {},
                    backgroundColorValue: Theme.of(
                      context,
                    ).scaffoldBackgroundColor,
                    nodeColorValue: Theme.of(context).colorScheme.primary,
                    edgeColorValue: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    onPossibleEdgeClick: null,
                  ),
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
            child: ThirdLevelInfo(
              title: currentStage.title,
              richText: currentStage.richText,
              onStageChanged: (index) {
                setState(() {
                  _currentStageIndex = index;
                });
              },
              totalStages: _stages.length,
              onComplete: () {
                showFinishLevelDialog(context, 5);
              },
            ),
          ),
        ],
      ),
    );
  }
}
