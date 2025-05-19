import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/models/model.dart';
import '../../features/level/models/stage.dart';
import '../../features/level/ui/widget.dart';
import '../../features/levels/finish_level_dialog.dart';

class SecondLevelPage extends StatelessWidget {
  const SecondLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      stages: [
        LevelStageModel.info(
          title: context.t.strings.levels.k2.stages.k1.title,
          richText: context.t.strings.levels.k2.stages.k1.richText(
            redNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            greenNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.green),
            ),
            blueNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.blue),
            ),
          ),
          graphModel: GraphModel.fromAdjacencyMatrix(
            [
              [0, 1, 1, 0],
              [1, 0, 0, 1],
              [1, 0, 0, 1],
              [0, 1, 1, 0],
            ],
            nodeColor: (nodeIndex) => switch (nodeIndex) {
              0 => Colors.blue,
              1 => Colors.red,
              2 => Colors.green,
              _ => null,
            },
          ),
        ),
        LevelStageModel.info(
          title: context.t.strings.levels.k2.stages.k2.title,
          richText: context.t.strings.levels.k2.stages.k2.richText(
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
          graphModel: GraphModel.fromAdjacencyMatrix(
            [
              [0, 1, 0, 0],
              [1, 0, 0, 0],
              [0, 0, 0, 1],
              [0, 0, 1, 0],
            ],
            nodeColor: (nodeIndex) => switch (nodeIndex) {
              1 => Colors.red,
              2 => Colors.blue,
              _ => null,
            },
          ),
        ),
        LevelStageModel.info(
          title: context.t.strings.levels.k2.stages.k3.title,
          text: context.t.strings.levels.k2.stages.k3.text,
          graphModel: GraphModel.fromAdjacencyMatrix([
            [0, 1, 0, 0, 0],
            [1, 0, 0, 0, 0],
            [0, 0, 0, 1, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0],
          ]),
        ),
        LevelStageModel.question(
          title: context.t.strings.levels.k2.stages.k4.title,
          text: context.t.strings.levels.k2.stages.k4.text,
          graphModel: GraphModel.fromAdjacencyMatrix([
            [0, 1, 0, 0, 0, 0, 0, 0],
            [1, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
          ]),
          answerHint: context.t.strings.enterNumberOfConnectivityComponents,
          correctAnswer: 5,
        ),
      ],
      onFinish: () => showFinishLevelDialog(context, 3),
    );
  }
}
