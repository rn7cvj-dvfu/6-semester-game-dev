import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/models/model.dart';
import '../../features/graph/ui/colors.dart';

import '../../features/level/models/stage.dart';
import '../../features/level/ui/widget.dart';
import '../../features/levels/finish_level_dialog.dart';

class FirstLevelPage extends StatelessWidget {
  const FirstLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      stages: [
        LevelStageModel.info(
          title: context.t.strings.levels.k1.stages.k1.title,
          text: context.t.strings.levels.k1.stages.k1.text,
          graphModel: GraphModel(
            nodes: [NodeModel(id: 'A', preferredPosition: (0, 0))],
            edges: [],
          ),
        ),
        LevelStageModel.info(
          title: context.t.strings.levels.k1.stages.k2.title,
          text: context.t.strings.levels.k1.stages.k2.text,
          graphModel: GraphModel.fromAdjacencyMatrix(
            [
              [0, 1],
              [1, 0],
            ],
            nodeColor: (nodeIndex) => nodeColors[nodeIndex % nodeColors.length],
          ),
        ),
        LevelStageModel.info(
          title: context.t.strings.levels.k1.stages.k3.title,
          text: context.t.strings.levels.k1.stages.k3.text,
          graphModel: GraphModel.fromAdjacencyMatrix(
            [
              [0, 1, 1],
              [1, 0, 1],
              [1, 1, 0],
            ],
            nodeColor: (nodeIndex) => nodeColors[nodeIndex % nodeColors.length],
          ),
        ),
      ],
      onFinish: () => showFinishLevelDialog(context, 2),
    );
  }
}
