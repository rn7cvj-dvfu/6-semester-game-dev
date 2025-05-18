import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/count_connected_components.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/levels/finish_level_dialog.dart';
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
        NodeModel(id: 'n1', preferredPosition: (-0.72, 0.45)),
        NodeModel(id: 'n2', preferredPosition: (-0.54, 0.675)),
        NodeModel(id: 'n3', preferredPosition: (-0.9, 0.225)),
        // Component 2
        NodeModel(id: 'n4', preferredPosition: (0.0, -0.675)),
        NodeModel(id: 'n5', preferredPosition: (0.18, -0.9)),
        NodeModel(id: 'n6', preferredPosition: (-0.18, -0.9)),
        // Component 3
        NodeModel(id: 'n7', preferredPosition: (0.72, 0.0)),
        NodeModel(id: 'n8', preferredPosition: (0.9, 0.225)),
        NodeModel(id: 'n9', preferredPosition: (0.54, -0.225)),
        // Isolated Nodes
        NodeModel(id: 'n10', preferredPosition: (-0.18, -0.225)),
        NodeModel(id: 'n11', preferredPosition: (0.36, 0.675)),
        NodeModel(id: 'n12', preferredPosition: (-0.54, -0.9)),
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
        final EdgeModel? newEdge;

        if (selectedNodeId != null &&
            (nodeId != selectedNodeId && selectedNodeId != null) &&
            displayGraphModel.edges.every(
              (e) => e.id != nodeId + selectedNodeId!,
            )) {
          newEdge = EdgeModel(
            id: nodeId + selectedNodeId!,
            firstNodeId: selectedNodeId!,
            secondNodeId: nodeId,
          );
        } else {
          newEdge = null;
        }

        displayGraphModel = displayGraphModel.copyWith(
          nodes: [
            for (final node in displayGraphModel.nodes)
              node.copyWith(
                preferredColor: selectedNodeId == null && node.id == nodeId
                    ? Colors.red
                    : null,
              ),
          ],
          edges: newEdge != null
              ? [...displayGraphModel.edges, newEdge]
              : [...displayGraphModel.edges],
        );

        selectedNodeId = selectedNodeId == null ? nodeId : null;

        updateGameState();
      },
      onEdgeClick: (edgeId) {},
    );
  }

  void updateGameState() {
    _graphGame!.replaceGraphModel(displayGraphModel);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
    if (_graphGame == null) {
      initGraphModel();
      initGame();
    } else {
      updateGameState();
    }
  }

  void resolve() {
    final count = countConnectedComponentsInGraph(displayGraphModel);
    if (count == 1) {
      showFinishLevelDialog(context, 4);
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        final t = Translations.of(context);
        return AlertDialog(
          title: Text(t.strings.levels.k3.taskNotCompleted),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(t.strings.levels.k3.returnButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: GSettings.maxDialogWidth,
                maxHeight: MediaQuery.sizeOf(context).height,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                primary: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    InfoCardWidget(
                      title: t.strings.levels.k3.connectThemAllTitle,
                      text: t.strings.levels.k3.connectThemAllDescription,
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              initGraphModel();
                              updateGameState();
                              selectedNodeId = null;
                            },
                            child: Text(t.strings.levels.k3.resetButton),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: resolve,
                            child: Text(t.strings.levels.k3.checkButton),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
