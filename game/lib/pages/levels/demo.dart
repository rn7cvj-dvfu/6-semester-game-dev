import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/settings.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class DemoLevelPage extends StatefulWidget {
  const DemoLevelPage({super.key});

  @override
  State<DemoLevelPage> createState() => _DemoLevelPageState();
}

class _DemoLevelPageState extends State<DemoLevelPage> {
  bool _movable = false;
  bool _clickable = false;
  bool _edgeColorLerp = false;
  bool _possibleEdgeClickable = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              child: GameWidget(
                key: ValueKey(
                  "$_movable$_clickable$_edgeColorLerp$_possibleEdgeClickable",
                ),
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
                    movable: _movable,
                    clickable: _clickable,
                    edgeColorLerp: _edgeColorLerp,
                    possibleEdgeClickable: _possibleEdgeClickable,
                  ),
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16),
              primary: false,
              child: Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InfoCardWidget(
                    title: context.t.strings.levels.k0.title,
                    text: context.t.strings.levels.k0.text,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: GSettings.maxDialogWidth,
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SwitchListTile(
                            value: _movable,
                            onChanged: (movable) {
                              setState(() {
                                _movable = movable;
                              });
                            },
                            title: const Text("Movable"),
                          ),
                          SwitchListTile(
                            value: _clickable,
                            onChanged: (clickable) {
                              setState(() {
                                _clickable = clickable;
                              });
                            },
                            title: const Text("Clickable"),
                          ),
                          SwitchListTile(
                            value: _edgeColorLerp,
                            onChanged: (edgeColorLerp) {
                              setState(() {
                                _edgeColorLerp = edgeColorLerp;
                              });
                            },
                            title: const Text("Edge Color Lerp"),
                          ),
                          SwitchListTile(
                            value: _possibleEdgeClickable,
                            onChanged: (possibleEdgeClickable) {
                              setState(() {
                                _possibleEdgeClickable = possibleEdgeClickable;
                              });
                            },
                            title: const Text("Possible Edge Clickable"),
                          ),
                        ],
                      ),
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
