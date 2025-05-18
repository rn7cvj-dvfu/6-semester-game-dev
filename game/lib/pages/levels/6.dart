import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/bloc/placement.dart';
import '../../features/graph/ui/colors.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/step_button.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/levels/1/adjacency_matrix_editor.dart';
import '../../features/levels/6/level_info.dart';
import '../../features/levels/finish_level_dialog.dart';
import '../../features/settings.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class SixthLevelPage extends StatefulWidget {
  const SixthLevelPage({super.key});

  @override
  State<SixthLevelPage> createState() => _SixthLevelPageState();
}

class _SixthLevelPageState extends State<SixthLevelPage> {
  @override
  Widget build(BuildContext context) {
    const transitionDuration = Duration(milliseconds: 500);

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32,
                left: 32 + 16,
                right: 32 + GSettings.maxDialogWidth + 16,
                bottom: 32,
              ),
              child: AnimatedSwitcher(
                duration: transitionDuration,
                child: GameWidget(
                  game: GraphWidget(
                    graphModel: GraphModel(
                      nodes: [
                        NodeModel(id: 'A'),
                        NodeModel(id: 'B'),
                        NodeModel(id: 'C'),
                        NodeModel(id: 'D'),
                        NodeModel(id: 'E'),
                        NodeModel(id: 'F'),
                        NodeModel(id: 'G'),
                        NodeModel(id: 'H'),
                        NodeModel(id: 'I'),
                        NodeModel(id: 'J'),
                        NodeModel(id: 'K'),
                        NodeModel(id: 'L'),
                        NodeModel(id: 'M'),
                      ],
                      edges: [
                        EdgeModel(
                          id: 'AB',
                          firstNodeId: 'A',
                          secondNodeId: 'B',
                        ),
                        EdgeModel(
                          id: 'AC',
                          firstNodeId: 'A',
                          secondNodeId: 'C',
                        ),
                        EdgeModel(
                          id: 'BD',
                          firstNodeId: 'B',
                          secondNodeId: 'D',
                        ),
                        EdgeModel(
                          id: 'BE',
                          firstNodeId: 'B',
                          secondNodeId: 'E',
                        ),
                        EdgeModel(
                          id: 'CF',
                          firstNodeId: 'C',
                          secondNodeId: 'F',
                        ),
                        EdgeModel(
                          id: 'CG',
                          firstNodeId: 'C',
                          secondNodeId: 'G',
                        ),
                        EdgeModel(
                          id: 'DH',
                          firstNodeId: 'D',
                          secondNodeId: 'H',
                        ),
                        EdgeModel(
                          id: 'DI',
                          firstNodeId: 'D',
                          secondNodeId: 'I',
                        ),
                        EdgeModel(
                          id: 'EJ',
                          firstNodeId: 'E',
                          secondNodeId: 'J',
                        ),
                        EdgeModel(
                          id: 'EK',
                          firstNodeId: 'E',
                          secondNodeId: 'K',
                        ),
                        EdgeModel(
                          id: 'FL',
                          firstNodeId: 'F',
                          secondNodeId: 'L',
                        ),
                        EdgeModel(
                          id: 'FM',
                          firstNodeId: 'F',
                          secondNodeId: 'M',
                        ),
                      ],
                      placement: GraphNodesPlacement.tree(topNodeId: 'A'),
                    ),
                    backgroundColorValue: Theme.of(
                      context,
                    ).scaffoldBackgroundColor,
                    nodeColorValue: Theme.of(context).colorScheme.primary,
                    edgeColorValue: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
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
            child: SixthLevelInfo(
              title: "context.t.strings.levels.k6.stages.k1.title",
              text: "context.t.strings.levels.k6.stages.k1.text",
              onAnimationStartClick: () {},
            ),
          ),
          //   child: SingleChildScrollView(
          //     padding: EdgeInsets.symmetric(vertical: 16),
          //     primary: false,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       mainAxisSize: MainAxisSize.min,
          //       spacing: 8,
          //       children: [
          //         InfoCardWidget(
          //           title: currentStageData.infoTitle,
          //           text: currentStageData.infoText,
          //         ),
          //         StepButton(
          //           currentStage: _currentStageIndex,
          //           totalStages: _stages.length,
          //           onBack: _currentStageIndex > 0 ? _previousStage : null,
          //           onNext: _nextStage,
          //         ),

          //         if (isLastStage)
          //           AdjacencyMatrixEditor(
          //             initialGraph: currentStageData.graphModel,
          //             onMatrixChanged: (newMatrix) {
          //               setState(() {
          //                 _stages
          //                     .last
          //                     .graphModel = GraphModel.fromAdjacencyMatrix(
          //                   newMatrix,
          //                   clickable: currentStageData.graphModel.clickable,
          //                   movable: currentStageData.graphModel.movable,
          //                   nodeColor: (nodeIndex) =>
          //                       nodeColors[nodeIndex % nodeColors.length],
          //                 );
          //               });
          //             },
          //           ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
