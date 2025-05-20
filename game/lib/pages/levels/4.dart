import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/models/model.dart';
import '../../features/graph/models/placement.dart';
import '../../features/level/models/stage.dart';
import '../../features/level/ui/widget.dart';
import '../../features/levels/finish_level_dialog.dart';

class FourthLevelPage extends StatelessWidget {
  const FourthLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      stages: [
        LevelStageModel.info(
          title: context.t.strings.levels.k4.stages.k1.title,
          richText: context.t.strings.levels.k4.stages.k1.richText(
            redNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            blue: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
            ),
          ),
          graphModel: GraphModel(
            nodes: [
              NodeModel(id: 'A', preferredColor: Colors.red),
              NodeModel(id: 'B'),
              NodeModel(id: 'C'),
              NodeModel(id: 'D', preferredColor: Colors.blue),
            ],
            edges: [
              EdgeModel(id: 'A-B', firstNodeId: 'A', secondNodeId: 'B'),
              EdgeModel(id: 'B-C', firstNodeId: 'B', secondNodeId: 'C'),

              EdgeModel(id: 'C-D', firstNodeId: 'C', secondNodeId: 'D'),
            ],
          ),
        ),
        LevelStageModel.info(
          title: context.t.strings.levels.k4.stages.k2.title,
          richText: context.t.strings.levels.k4.stages.k2.richText(
            redNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            blueNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
            ),
          ),
          graphModel: GraphModel(
            nodes: [
              NodeModel(id: 'A', preferredColor: Colors.red),
              NodeModel(id: 'B'),
              NodeModel(id: 'C', preferredColor: Colors.blue),
            ],
            edges: [
              EdgeModel(id: 'A-B', firstNodeId: 'A', secondNodeId: 'B'),
              EdgeModel(id: 'B-C', firstNodeId: 'B', secondNodeId: 'C'),
            ],
          ),
        ),
        LevelStageModel.question(
          title: context.t.strings.levels.k4.stages.k3.title,
          richText: context.t.strings.levels.k4.stages.k3.richText(
            redNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            blueNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
            ),
          ),
          graphModel: GraphModel(
            placement: GraphNodesPlacement.random(seed: 69),
            nodes: [
              NodeModel(id: 'A', preferredColor: Colors.red),
              NodeModel(id: 'B'),
              NodeModel(id: 'C'),
              NodeModel(id: 'D'),
              NodeModel(id: 'E'),
              NodeModel(
                id: 'F',
                preferredColor: Colors.blue,
                preferredPosition: (0, 0),
              ),
            ],
            edges: [
              EdgeModel(id: 'A-B', firstNodeId: 'A', secondNodeId: 'B'),
              EdgeModel(id: 'B-C', firstNodeId: 'B', secondNodeId: 'C'),
              EdgeModel(id: 'C-D', firstNodeId: 'C', secondNodeId: 'D'),
              EdgeModel(id: 'D-E', firstNodeId: 'D', secondNodeId: 'E'),
              EdgeModel(id: 'E-F', firstNodeId: 'E', secondNodeId: 'F'),
            ],
          ),
          answerHint: context.t.strings.enterPathLength,
          correctAnswer: 5,
        ),
      ],
      onFinish: () => showFinishLevelDialog(context, 5),
    );
  }
}
