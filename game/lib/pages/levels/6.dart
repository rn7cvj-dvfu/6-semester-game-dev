import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../features/graph/bloc/model.dart';
import '../../features/graph/bloc/placement.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/levels/6/level_info.dart';
import '../../features/settings.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

class SixthLevelPage extends StatefulWidget {
  const SixthLevelPage({super.key});

  @override
  State<SixthLevelPage> createState() => _SixthLevelPageState();
}

class _SixthLevelPageState extends State<SixthLevelPage> {
  late final GraphWidget _graphWidget = GraphWidget(
    graphModel: _buildGraphModel(),
    backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
    nodeColorValue: Theme.of(context).colorScheme.primary,
    edgeColorValue: Theme.of(context).colorScheme.primaryContainer,
    onNodeClick: (nodeId) {},
    onEdgeClick: (edgeId) {},
  );
  List<String> _bfsOrder = [];
  int _bfsStep = -1;
  bool _isAnimating = false;
  bool _shouldStopAnimation = false;

  GraphModel _buildGraphModel() {
    return GraphModel(
      nodes: [
        for (final id in [
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
        ])
          NodeModel(
            id: id,
            preferredColor:
                (_bfsStep >= 0 &&
                    _bfsOrder.isNotEmpty &&
                    _bfsOrder[_bfsStep] == id)
                ? Colors.green
                : null,
          ),
      ],
      edges: [
        EdgeModel(id: 'AB', firstNodeId: 'A', secondNodeId: 'B'),
        EdgeModel(id: 'AC', firstNodeId: 'A', secondNodeId: 'C'),
        EdgeModel(id: 'BD', firstNodeId: 'B', secondNodeId: 'D'),
        EdgeModel(id: 'BE', firstNodeId: 'B', secondNodeId: 'E'),
        EdgeModel(id: 'CF', firstNodeId: 'C', secondNodeId: 'F'),
        EdgeModel(id: 'CG', firstNodeId: 'C', secondNodeId: 'G'),
        EdgeModel(id: 'DH', firstNodeId: 'D', secondNodeId: 'H'),
        EdgeModel(id: 'DI', firstNodeId: 'D', secondNodeId: 'I'),
        EdgeModel(id: 'EJ', firstNodeId: 'E', secondNodeId: 'J'),
        EdgeModel(id: 'EK', firstNodeId: 'E', secondNodeId: 'K'),
        EdgeModel(id: 'FL', firstNodeId: 'F', secondNodeId: 'L'),
        EdgeModel(id: 'FM', firstNodeId: 'F', secondNodeId: 'M'),
      ],
      placement: GraphNodesPlacement.tree(topNodeId: 'A'),
    );
  }

  List<String> _bfsOrderForTree() {
    // BFS для текущей структуры дерева
    final edges = [
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
    final Map<String, List<String>> graph = {};
    for (final e in edges) {
      graph.putIfAbsent(e[0], () => []).add(e[1]);
    }
    final List<String> order = [];
    final queue = <String>['A'];
    final visited = <String>{'A'};
    while (queue.isNotEmpty) {
      final node = queue.removeAt(0);
      order.add(node);
      for (final child in graph[node] ?? []) {
        if (!visited.contains(child)) {
          visited.add(child);
          queue.add(child);
        }
      }
    }
    return order;
  }

  Future<void> _startBfsAnimation() async {
    if (_isAnimating) return;
    setState(() {
      _bfsOrder = _bfsOrderForTree();
      _bfsStep = -1;
      _isAnimating = true;
      _shouldStopAnimation = false;
    });
    await _graphWidget.replaceGraphModel(_buildGraphModel());
    for (int i = 0; i < _bfsOrder.length; i++) {
      if (_shouldStopAnimation) break;
      await Future.delayed(const Duration(milliseconds: 600));
      if (_shouldStopAnimation) break;
      setState(() {
        _bfsStep = i;
      });
      await _graphWidget.replaceGraphModel(_buildGraphModel());
    }
    setState(() {
      _bfsStep = -1;
      _isAnimating = false;
      _shouldStopAnimation = false;
    });
    await _graphWidget.replaceGraphModel(_buildGraphModel());
  }

  void _stopBfsAnimation() {
    setState(() {
      _shouldStopAnimation = true;
      _bfsStep = -1;
      _isAnimating = false;
    });
    _graphWidget.replaceGraphModel(_buildGraphModel());
  }

  @override
  Widget build(BuildContext context) {
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
              child: GameWidget(game: _graphWidget),
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
              onAnimationStartClick: _startBfsAnimation,
              onAnimationStopClick: _stopBfsAnimation,
              canStart: !_isAnimating,
              canStop: _isAnimating,
            ),
          ),
        ],
      ),
    );
  }
}
