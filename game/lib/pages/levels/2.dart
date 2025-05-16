import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/step_button.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/settings.dart';
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
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 1, 0],
          [1, 0, 0, 1],
          [1, 0, 0, 1],
          [0, 1, 1, 0],
        ],
      ),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k2.stages.k2.title,
      infoText: context.t.strings.levels.k2.stages.k2.text,
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 0, 0],
          [1, 0, 0, 0],
          [0, 0, 0, 1],
          [0, 0, 1, 0],
        ],
      ),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k2.stages.k3.title,
      infoText: context.t.strings.levels.k2.stages.k3.text,
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 0, 0, 0],
          [1, 0, 0, 0, 0],
          [0, 0, 0, 1, 0],
          [0, 0, 1, 0, 0],
          [0, 0, 0, 0, 0],
        ],
      ),
    ),
    _SubStage(
      infoTitle: context.t.strings.levels.k2.stages.k4.title,
      infoText: context.t.strings.levels.k2.stages.k4.text,
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 0, 0, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 1, 0, 0, 0, 0],
          [0, 0, 1, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 1, 0, 0],
          [0, 0, 0, 0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0],
        ],
      ),
    ),
  ];

  void _previousStage() {
    if (_currentStageIndex > 0) {
      _currentStageIndex--;
      setState(() {});
    }
  }

  void _nextStage() {
    if (_currentStageIndex < _stages.length - 1) {
      _currentStageIndex++;
      setState(() {});
      return;
    }

    AppNavigator.openLevels();
  }

  @override
  Widget build(BuildContext context) {
    final currentStageData = _stages[_currentStageIndex];
    const transitionDuration = Duration(milliseconds: 500);

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
                  onNodeClick: (nodeId) {},
                  onEdgeClick: (edgeId) {},
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
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  InfoCardWidget(
                    title: currentStageData.infoTitle,
                    text: currentStageData.infoText,
                  ),
                  StepButton(
                    currentStage: _currentStageIndex,
                    totalStages: _stages.length,
                    onBack: _currentStageIndex == 0 ? null : _previousStage,
                    onNext: _nextStage,
                  ),
                  if (_currentStageIndex == 3)
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: GSettings.maxDialogWidth,
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            decoration: InputDecoration(
                              labelText:
                                  "Введите количество компонент связности",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
