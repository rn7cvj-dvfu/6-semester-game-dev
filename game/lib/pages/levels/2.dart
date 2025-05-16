import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
      infoTitle: "Этап 1: Связный граф",
      infoText:
          "Этот граф является связным. Это означает, что из любой вершины можно достичь любую другую вершину, двигаясь по ребрам.",
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
      infoTitle: "Этап 2: Несвязный граф",
      infoText:
          "Этот граф не является связным. Он состоит из двух отдельных частей, называемых компонентами связности. Нельзя перейти из одной части в другую.",
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
      infoTitle: "Этап 3: Компоненты связности",
      infoText:
          "Здесь три компоненты связности. Каждая компонента - это максимальный связный подграф. То есть, внутри каждой компоненты все вершины связаны, но нет связей между разными компонентами.",
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 0, 0, 0],
          [1, 0, 0, 0, 0],
          [0, 0, 0, 1, 0],
          [0, 0, 1, 0, 0],
          [0, 0, 0, 0, 0], // Изолированная вершина - тоже компонента
        ],
      ),
    ),
    _SubStage(
      infoTitle: "Этап 4: Сколько компонент связности?",
      infoText:
          "Перед вами граф с несколькими компонентами связности. Сколько их?",
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          // Компонента 1 (0-1)
          [0, 1, 0, 0, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0, 0, 0],
          // Компонента 2 (2-3)
          [0, 0, 0, 1, 0, 0, 0, 0],
          [0, 0, 1, 0, 0, 0, 0, 0],
          // Компонента 3 (4-5)
          [0, 0, 0, 0, 0, 1, 0, 0],
          [0, 0, 0, 0, 1, 0, 0, 0],
          // Компонента 4 (6)
          [0, 0, 0, 0, 0, 0, 0, 0],
          // Компонента 4 (7)
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
                  dotColorValue: Theme.of(context).colorScheme.primary,
                  connectionEdgeColorValue:
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
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: TextField(
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
