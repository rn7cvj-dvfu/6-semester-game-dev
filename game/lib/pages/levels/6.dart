import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/models/model.dart';
import '../../features/graph/models/placement.dart';
import '../../features/level/models/stage.dart';
import '../../features/level/ui/widget.dart';
import '../../features/levels/6/level_info.dart';
import '../../features/levels/finish_level_dialog.dart';

class SixthLevelPage extends StatelessWidget {
  const SixthLevelPage({super.key});

  static const nodeIds = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
  ];
  static const edges = [
    ['A', 'B'],
    ['A', 'C'],
    ['B', 'D'],
    ['B', 'E'],
    ['C', 'F'],
    ['C', 'G'],
    ['D', 'H'],
    ['D', 'I'],
    ['E', 'J'],
    ['E', 'K'],
    ['F', 'L'],
    ['F', 'M'],
  ];
  static final edgeModels = [
    for (final e in edges)
      EdgeModel(id: e[0] + e[1], firstNodeId: e[0], secondNodeId: e[1]),
  ];
  static final graphModel = GraphModel(
    nodes: [for (final id in nodeIds) NodeModel(id: id)],
    edges: edgeModels,
    placement: GraphNodesPlacement.tree(topNodeId: 'A'),
  );
  
  static const List<Map<String, Color>> animationSteps = [
    {'A': Colors.green, 'B': Colors.orange, 'C': Colors.orange},
    {
      'A': Colors.black,
      'B': Colors.green,
      'C': Colors.orange,
      'D': Colors.orange,
      'E': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.green,
      'D': Colors.orange,
      'E': Colors.orange,
      'F': Colors.orange,
      'G': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.green,
      'E': Colors.orange,
      'F': Colors.orange,
      'G': Colors.orange,
      'H': Colors.orange,
      'I': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.green,
      'F': Colors.orange,
      'G': Colors.orange,
      'H': Colors.orange,
      'I': Colors.orange,
      'J': Colors.orange,
      'K': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.green,
      'G': Colors.orange,
      'H': Colors.orange,
      'I': Colors.orange,
      'J': Colors.orange,
      'K': Colors.orange,
      'L': Colors.orange,
      'M': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.green,
      'H': Colors.orange,
      'I': Colors.orange,
      'J': Colors.orange,
      'K': Colors.orange,
      'L': Colors.orange,
      'M': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.black,
      'H': Colors.green,
      'I': Colors.orange,
      'J': Colors.orange,
      'K': Colors.orange,
      'L': Colors.orange,
      'M': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.black,
      'H': Colors.black,
      'I': Colors.green,
      'J': Colors.orange,
      'K': Colors.orange,
      'L': Colors.orange,
      'M': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.black,
      'H': Colors.black,
      'I': Colors.black,
      'J': Colors.green,
      'K': Colors.orange,
      'L': Colors.orange,
      'M': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.black,
      'H': Colors.black,
      'I': Colors.black,
      'J': Colors.black,
      'K': Colors.green,
      'L': Colors.orange,
      'M': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.black,
      'H': Colors.black,
      'I': Colors.black,
      'J': Colors.black,
      'K': Colors.black,
      'L': Colors.green,
      'M': Colors.orange,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.black,
      'H': Colors.black,
      'I': Colors.black,
      'J': Colors.black,
      'K': Colors.black,
      'L': Colors.black,
      'M': Colors.green,
    },
    {
      'A': Colors.black,
      'B': Colors.black,
      'C': Colors.black,
      'D': Colors.black,
      'E': Colors.black,
      'F': Colors.black,
      'G': Colors.black,
      'H': Colors.black,
      'I': Colors.black,
      'J': Colors.black,
      'K': Colors.black,
      'L': Colors.black,
      'M': Colors.black,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LevelWidget(
      stages: [
        LevelStageModel.animation(
          title: context.t.strings.levels.k6.stages.k1.title,
          richText: context.t.strings.levels.k6.stages.k1.richText(
            greenNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.green),
            ),
            orangeNode: (text) => TextSpan(
              text: text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.orange),
            ),
          ),
          graphModel: graphModel,
          animationSteps: animationSteps,
          animationDurationMs: const Duration(milliseconds: 600),
        ),
      ],
      onFinish: () => showFinishLevelDialog(context),
    );
  }
}
