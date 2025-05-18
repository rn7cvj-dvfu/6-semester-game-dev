import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/settings.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class ThirdLevelPage extends StatefulWidget {
  const ThirdLevelPage({super.key});

  @override
  State<ThirdLevelPage> createState() => _ThirdLevelPageState();
}

class _ThirdLevelPageState extends State<ThirdLevelPage> {
  late GraphModel displayGraphModel;

  String? selectedNodeId;

  final _gameWidgetKey = GlobalKey();
  GraphWidget? _graphGame;

  void initGraphModel() {
    displayGraphModel = GraphModel(
      nodes: [
        // Component 1
        NodeModel(id: 'n1', preferredPosition: (-0.8, 0.5)),
        NodeModel(id: 'n2', preferredPosition: (-0.6, 0.75)),
        NodeModel(id: 'n3', preferredPosition: (-1.0, 0.25)),
        // Component 2
        NodeModel(id: 'n4', preferredPosition: (0.0, -0.75)),
        NodeModel(id: 'n5', preferredPosition: (0.2, -1.0)),
        NodeModel(id: 'n6', preferredPosition: (-0.2, -1.0)),
        // Component 3
        NodeModel(id: 'n7', preferredPosition: (0.8, 0.0)),
        NodeModel(id: 'n8', preferredPosition: (1.0, 0.25)),
        NodeModel(id: 'n9', preferredPosition: (0.6, -0.25)),
        // Isolated Nodes
        NodeModel(id: 'n10', preferredPosition: (-0.2, -0.25)),
        NodeModel(id: 'n11', preferredPosition: (0.4, 0.75)),
        NodeModel(id: 'n12', preferredPosition: (-0.6, -1.0)),
      ],
      edges: [
        // Edges for Component 1
        EdgeModel(id: 'e1', firstNodeId: 'n1', secondNodeId: 'n2'),
        EdgeModel(id: 'e2', firstNodeId: 'n1', secondNodeId: 'n3'),
        // Edges for Component 2 (forms a triangle)
        EdgeModel(id: 'e3', firstNodeId: 'n4', secondNodeId: 'n5'),
        EdgeModel(id: 'e4', firstNodeId: 'n4', secondNodeId: 'n6'),
        EdgeModel(id: 'e5', firstNodeId: 'n5', secondNodeId: 'n6'),
        // Edges for Component 3
        EdgeModel(id: 'e6', firstNodeId: 'n7', secondNodeId: 'n8'),
        EdgeModel(id: 'e7', firstNodeId: 'n7', secondNodeId: 'n9'),
      ],
      clickable: true,
    );
  }

  void initGame() {
    _graphGame = GraphWidget(
      graphModel: displayGraphModel,
      backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
      nodeColorValue: Theme.of(context).colorScheme.primary,
      edgeColorValue: Theme.of(context).colorScheme.primaryContainer,
      onNodeClick: (nodeId) {
        displayGraphModel = displayGraphModel.copyWith(
          nodes: [
            for (final node in displayGraphModel.nodes)
              node.copyWith(
                preferredColor: selectedNodeId == null && node.id == nodeId
                    ? Colors.red
                    : null,
              ),
          ],
          edges: [
            for (final edge in displayGraphModel.edges) edge,
            if (nodeId != selectedNodeId && selectedNodeId != null)
              EdgeModel(
                id: nodeId + selectedNodeId!,
                firstNodeId: selectedNodeId!,
                secondNodeId: nodeId,
              ),
          ],
        );

        selectedNodeId = selectedNodeId == null ? nodeId : null;

        updateGameState();
      },
      onEdgeClick: (edgeId) {},
    );
  }

  void updateGameState() {
    _graphGame!.replaceGraphModel(displayGraphModel);
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    MediaQuery.sizeOf(context);
    if (_graphGame == null) {
      initGraphModel();
      initGame();
    } else {
      updateGameState();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Translations.of(context);

    return Material(
      child: Stack(
        children: [
          Positioned(
            top: 56 + 16 + 32,
            bottom: 32,
            left: 32,
            right: GSettings.maxDialogWidth + 16,
            child: GameWidget(key: _gameWidgetKey, game: _graphGame!),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              primary: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  InfoCardWidget(
                    title: 'Соедини их всех!',
                    text:
                        'Сделайте граф связным, добавив минимальное количество новых ребер. Текущий граф состоит из нескольких отдельных частей.',
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: GSettings.maxDialogWidth,
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              initGraphModel();
                              updateGameState();
                            },
                            child: const Text('Сбросить'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Не сбрасывать'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
