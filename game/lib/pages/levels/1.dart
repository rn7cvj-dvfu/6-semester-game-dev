import 'package:flame/game.dart';
import 'package:flutter/material.dart';
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

  // Helper function to convert adjacency matrix to GraphModel
  GraphModel _createGraphModelFromAdjacencyMatrix(List<List<int>> matrix,
      {bool movable = false, bool clickable = false}) {
    final nodes = <NodeModel>[];
    for (int i = 0; i < matrix.length; i++) {
      nodes.add(NodeModel(id: 'node_$i'));
    }

    final edges = <EdgeModel>[];
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == 1) {
          // Ensure edges are added once for undirected graphs, typically j > i
          if (j > i) {
            edges.add(EdgeModel(
                id: 'edge_${i}_$j',
                firstNodeId: 'node_$i',
                secondNodeId: 'node_$j'));
          }
        }
      }
    }
    return GraphModel(
        nodes: nodes, edges: edges, movable: movable, clickable: clickable);
  }

  late final List<_SubStage> _stages = [
    _SubStage(
      infoTitle: "Этап 1: Знакомство",
      infoText:
          "Это первый этап. Посмотрите на граф. Он состоит из двух точек и одной связи.",
      graphModel: _createGraphModelFromAdjacencyMatrix([
        [0, 1],
        [1, 0],
      ], clickable: true),
    ),
    _SubStage(
      infoTitle: "Этап 2: Больше точек",
      infoText: "Теперь точек три, и они соединены по кругу.",
      graphModel: _createGraphModelFromAdjacencyMatrix([
        [0, 1, 1],
        [1, 0, 1],
        [1, 1, 0],
      ], clickable: true),
    ),
    _SubStage(
      infoTitle: "Этап 3: Изолированная точка",
      infoText: "На этом этапе одна из точек не имеет связей.",
      graphModel: _createGraphModelFromAdjacencyMatrix([
        [0, 1, 0],
        [1, 0, 0],
        [0, 0, 0],
      ], clickable: true),
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
    final currentStage = _stages[_currentStageIndex];

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: GameWidget(
              game: GraphWidget(
                graphModel: currentStage.graphModel,
                backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
                dotColorValue: Theme.of(context).colorScheme.primary,
                connectionEdgeColorValue:
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
                  title: currentStage.infoTitle,
                  text: currentStage.infoText,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 384,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed:
                              _currentStageIndex > 0 ? _previousStage : null,
                          child: const Text("Назад"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${_currentStageIndex + 1} / ${_stages.length}'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _nextStage,
                          child: Text(_currentStageIndex < _stages.length - 1
                              ? "Далее"
                              : "Завершить"),
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
