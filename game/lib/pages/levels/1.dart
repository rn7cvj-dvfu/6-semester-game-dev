import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

// Data class for sub-stage information
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

class FirstLevelPage extends StatefulWidget {
  const FirstLevelPage({super.key});

  @override
  State<FirstLevelPage> createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  int _currentStageIndex = 0;

  late final List<_SubStage> _stages = [
    _SubStage(
      infoTitle: context.t.strings.levels.k1.stages.k1.title,
      infoText: context.t.strings.levels.k1.stages.k1.text,
      graphModel: GraphModel(
        nodes: [
          NodeModel(id: 'hui', preferredPosition: (0, 0)),
        ],
        edges: [],
      ),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k1.stages.k2.title,
      infoText: context.t.strings.levels.k1.stages.k2.text,
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1],
          [1, 0],
        ],
        clickable: true,
        movable: true,
      ),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k1.stages.k3.title,
      infoText: context.t.strings.levels.k1.stages.k3.text,
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 1],
          [1, 0, 1],
          [1, 1, 0],
        ],
        clickable: true,
        movable: true,
      ),
    ),
  ];

  void _previousStage() {
    if (_currentStageIndex > 0) {
      setState(() {
        _currentStageIndex--;
      });
    }
  }

  void _nextStage() {
    if (_currentStageIndex < _stages.length - 1) {
      setState(() {
        _currentStageIndex++;
      });
    } else {
      AppNavigator.openLevels();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStageData = _stages[_currentStageIndex];
    const transitionDuration = Duration(milliseconds: 500);
    Translations.of(context);

    return Material(
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: transitionDuration,
            child: Positioned.fill(
              key: ValueKey(currentStageData.graphModel),
              child: GameWidget(
                game: GraphWidget(
                  graphModel: currentStageData.graphModel,
                  backgroundColorValue:
                      Theme.of(context).scaffoldBackgroundColor,
                  nodeColorValue: Theme.of(context).colorScheme.primary,
                  edgeColorValue:
                      Theme.of(context).colorScheme.primaryContainer,
                  onNodeClick: (nodeId) {
                    // print('Node $nodeId clicked');
                  },
                  onEdgeClick: (edgeId) {
                    // print('Edge $edgeId clicked');
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GBackButton(
              onTap: AppNavigator.openLevels,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                InfoCardWidget(
                  title: currentStageData.infoTitle,
                  text: currentStageData.infoText,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 384,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 8,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              _currentStageIndex > 0 ? _previousStage : null,
                          child: Text(context.t.strings.common.back),
                        ),
                      ),
                      Text('${_currentStageIndex + 1} / ${_stages.length}'),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _nextStage,
                          child: Text(_currentStageIndex < _stages.length - 1
                              ? context.t.strings.common.next
                              : context.t.strings.common.finish),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
