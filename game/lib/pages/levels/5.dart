import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/models/model.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/levels/5/level_info.dart';
import '../../features/levels/finish_level_dialog.dart';
import '../../features/settings.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class FifthLevelPage extends StatefulWidget {
  const FifthLevelPage({super.key});

  @override
  State<FifthLevelPage> createState() => _FifthLevelPageState();
}

class _FifthLevelPageState extends State<FifthLevelPage> {
  // 1. Граф-лабиринт (14 вершин)
  late final List<NodeModel> _nodes = [
    NodeModel(id: 'A', preferredPosition: (-1.0, 0.5)),
    NodeModel(id: 'B', preferredPosition: (-0.5, 0.5)),
    NodeModel(id: 'C', preferredPosition: (0.0, 0.5)),
    NodeModel(id: 'D', preferredPosition: (0.5, 0.5)),
    NodeModel(id: 'E', preferredPosition: (1.0, 0.5)),
    NodeModel(id: 'F', preferredPosition: (1.0, 0.0)),
    NodeModel(id: 'G', preferredPosition: (1.0, -0.5)),
    NodeModel(id: 'H', preferredPosition: (0.5, -0.5)),
    NodeModel(id: 'I', preferredPosition: (0.0, -0.5)),
    NodeModel(id: 'J', preferredPosition: (-0.5, -0.5)),
    NodeModel(id: 'K', preferredPosition: (-1.0, -0.5)),
    NodeModel(id: 'L', preferredPosition: (-1.0, 0.0)),
    NodeModel(id: 'M', preferredPosition: (0.0, 0.0)),
    NodeModel(id: 'N', preferredPosition: (0.5, 0.0)),
  ];

  late final List<EdgeModel> _edges = [
    EdgeModel(id: 'e1', firstNodeId: 'A', secondNodeId: 'B'),
    EdgeModel(id: 'e2', firstNodeId: 'B', secondNodeId: 'C'),
    EdgeModel(id: 'e3', firstNodeId: 'C', secondNodeId: 'D'),
    EdgeModel(id: 'e4', firstNodeId: 'D', secondNodeId: 'E'),
    EdgeModel(id: 'e5', firstNodeId: 'E', secondNodeId: 'F'),
    EdgeModel(id: 'e6', firstNodeId: 'F', secondNodeId: 'G'),
    EdgeModel(id: 'e7', firstNodeId: 'G', secondNodeId: 'H'),
    EdgeModel(id: 'e8', firstNodeId: 'H', secondNodeId: 'I'),
    EdgeModel(id: 'e9', firstNodeId: 'I', secondNodeId: 'J'),
    EdgeModel(id: 'e10', firstNodeId: 'J', secondNodeId: 'K'),
    EdgeModel(id: 'e11', firstNodeId: 'K', secondNodeId: 'L'),
    EdgeModel(id: 'e12', firstNodeId: 'L', secondNodeId: 'A'),
    EdgeModel(id: 'e13', firstNodeId: 'I', secondNodeId: 'M'),
    EdgeModel(id: 'e14', firstNodeId: 'M', secondNodeId: 'N'),
    EdgeModel(id: 'e15', firstNodeId: 'N', secondNodeId: 'D'),
    EdgeModel(id: 'e16', firstNodeId: 'M', secondNodeId: 'C'),
    EdgeModel(id: 'e17', firstNodeId: 'M', secondNodeId: 'B'),
    EdgeModel(id: 'e18', firstNodeId: 'N', secondNodeId: 'H'),
  ];

  final String _startNodeId = 'A';
  final String _endNodeId = 'G';
  late final List<String> _userPath = [_startNodeId];
  late String _currentNodeId = _startNodeId;

  List<String> _findShortestPath(String from, String to) {
    final queue = <List<String>>[
      [from],
    ];
    final visited = <String>{from};
    while (queue.isNotEmpty) {
      final path = queue.removeAt(0);
      final last = path.last;
      if (last == to) return path;
      for (final e in _edges) {
        if (e.firstNodeId == last && !visited.contains(e.secondNodeId)) {
          visited.add(e.secondNodeId);
          queue.add([...path, e.secondNodeId]);
        } else if (e.secondNodeId == last && !visited.contains(e.firstNodeId)) {
          visited.add(e.firstNodeId);
          queue.add([...path, e.firstNodeId]);
        }
      }
    }
    return [];
  }

  void _onNodeClick(String nodeId) {
    final neighbors = _edges
        .where(
          (e) =>
              e.firstNodeId == _currentNodeId ||
              e.secondNodeId == _currentNodeId,
        )
        .map(
          (e) =>
              e.firstNodeId == _currentNodeId ? e.secondNodeId : e.firstNodeId,
        )
        .toSet();

    if (neighbors.contains(nodeId) && !_userPath.contains(nodeId)) {
      setState(() {
        _currentNodeId = nodeId;
        _userPath.add(nodeId);
      });
      if (nodeId == _endNodeId) {
        _findShortestPath(_startNodeId, _endNodeId);
        showFinishLevelDialog(context, 6);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.widthOf(context) <= GSettings.maxPhoneWidth;
    final sidePadding = isMobile ? 16.0 : 16.0;
    final topPadding = isMobile ? 16.0 : 16.0 + 64;
    final bottomPadding = isMobile ? 16.0 : 16.0;
    final rightPadding = isMobile ? 16.0 : GSettings.maxDialogWidth + 16 + 16;
    final maxDialogWidth = isMobile
        ? double.infinity
        : GSettings.maxDialogWidth;

    final nodes = _nodes.map((node) {
      Color? color;
      if (node.id == _currentNodeId) {
        color = Colors.red;
      } else if (node.id == _endNodeId) {
        color = Colors.blue;
      } else {
        final neighbors = _edges
            .where(
              (e) =>
                  e.firstNodeId == _currentNodeId ||
                  e.secondNodeId == _currentNodeId,
            )
            .map(
              (e) => e.firstNodeId == _currentNodeId
                  ? e.secondNodeId
                  : e.firstNodeId,
            )
            .toSet();
        if (neighbors.contains(node.id) && !_userPath.contains(node.id)) {
          color = Colors.orange;
        }
      }
      return node.copyWith(preferredColor: color);
    }).toList();

    final infoCard = FifthLevelInfo(
      title: context.t.strings.levels.k5.stages.k1.title,
      richText: context.t.strings.levels.k5.stages.k1.richText(
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
        redNode2: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.red),
        ),
        orangeNode: (text) => TextSpan(
          text: text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.orange),
        ),
      ),
    );

    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: topPadding,
                left: sidePadding,
                right: rightPadding,
                bottom: bottomPadding,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                child: GameWidget(
                  key: ValueKey(_userPath.length),
                  game: GraphWidget(
                    graphModel: GraphModel(
                      nodes: nodes,
                      edges: _edges,
                      clickable: true,
                    ),
                    backgroundColorValue: Theme.of(
                      context,
                    ).scaffoldBackgroundColor,
                    nodeColorValue: Theme.of(context).colorScheme.primary,
                    edgeColorValue: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    onNodeClick: _onNodeClick,
                    onEdgeClick: (_) {},
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
          if (!isMobile)
            Positioned(
              top: 0,
              right: 16,
              bottom: 0,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxDialogWidth,
                  maxHeight: MediaQuery.sizeOf(context).height,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  primary: false,
                  child: infoCard,
                ),
              ),
            ),
          if (isMobile)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: infoCard,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
