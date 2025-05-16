import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class DemoLevelPage extends StatelessWidget {
  const DemoLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: GameWidget(
              game: GraphWidget(
                backgroundColorValue: theme.scaffoldBackgroundColor,
                nodeColorValue: theme.colorScheme.primary,
                edgeColorValue: theme.colorScheme.primaryContainer,
                graphModel: GraphModel(
                  nodes: [
                    NodeModel(id: "1", preferredPosition: (0, 0)),
                    NodeModel(
                      id: "2",
                      preferredColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    NodeModel(id: "3"),
                    NodeModel(id: "4"),
                    NodeModel(id: "5"),
                  ],
                  edges: [
                    EdgeModel(id: "1", firstNodeId: "1", secondNodeId: "2"),
                    EdgeModel(id: "2", firstNodeId: "1", secondNodeId: "3"),
                    EdgeModel(id: "3", firstNodeId: "1", secondNodeId: "4"),
                    EdgeModel(id: "4", firstNodeId: "1", secondNodeId: "5"),
                    EdgeModel(id: "5", firstNodeId: "2", secondNodeId: "3"),
                    EdgeModel(id: "6", firstNodeId: "3", secondNodeId: "4"),
                    EdgeModel(
                      id: "7",
                      firstNodeId: "4",
                      secondNodeId: "5",
                      preferredColor: Theme.of(context).colorScheme.tertiary,
                    ),
                  ],
                  movable: true,
                  clickable: false,
                ),
                onNodeClick: (nodeId) {},
                onEdgeClick: (edgeId) {},
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
            bottom: 16,
            right: 16,
            child: InfoCardWidget(
                title: "Информация о уровне",
                text: "Это демонстрационный уровень с отобрженим графа "),
          )
        ],
      ),
    );
  }
}
