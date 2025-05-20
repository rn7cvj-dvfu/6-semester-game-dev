import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/models/model.dart';
import '../../features/graph/models/placement.dart';
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
  List<Set<String>> _bfsVisitedHistory = [];
  List<String> _bfsJustAdded = [];

  GraphModel _buildGraphModel() {
    // Определяем цвета для каждой вершины
    Set<String> visited = {};
    List<String> justAdded = [];
    String? current;
    if (_bfsStep >= 0 && _bfsStep < _bfsOrder.length) {
      current = _bfsOrder[_bfsStep];
      if (_bfsVisitedHistory.isNotEmpty &&
          _bfsStep < _bfsVisitedHistory.length) {
        visited = _bfsVisitedHistory[_bfsStep].toSet();
      }
      justAdded = _bfsJustAdded;
    }
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
            preferredColor: current == id
                ? Colors.green
                : justAdded.contains(id)
                ? Colors.orange
                : (visited.contains(id) ? Colors.black : null),
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
      _bfsVisitedHistory = [];
      _bfsJustAdded = [];
    });
    await _graphWidget.replaceGraphModel(_buildGraphModel());

    // BFS с историей посещённых
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
    final visitedHistory = <Set<String>>{...[]};
    final justAddedHistory = <List<String>>[];
    while (queue.isNotEmpty) {
      final node = queue.removeAt(0);
      order.add(node);
      final justAdded = <String>[];
      for (final child in graph[node] ?? []) {
        if (!visited.contains(child)) {
          visited.add(child);
          queue.add(child);
          justAdded.add(child);
        }
      }
      visitedHistory.add(Set<String>.from(order));
      justAddedHistory.add(justAdded);
    }
    // Анимация по шагам
    for (int i = 0; i < order.length; i++) {
      if (_shouldStopAnimation) break;
      await Future.delayed(const Duration(milliseconds: 600));
      if (_shouldStopAnimation) break;
      setState(() {
        _bfsOrder = order;
        _bfsStep = i;
        _bfsVisitedHistory = visitedHistory.toList();
        _bfsJustAdded = justAddedHistory[i];
      });
      await _graphWidget.replaceGraphModel(_buildGraphModel());
    }
    setState(() {
      _bfsStep = -1;
      _isAnimating = false;
      _shouldStopAnimation = false;
      _bfsJustAdded = [];
    });
    await _graphWidget.replaceGraphModel(_buildGraphModel());
  }

  void _stopBfsAnimation() {
    setState(() {
      _shouldStopAnimation = true;
      _bfsStep = -1;
      _isAnimating = false;
      _bfsJustAdded = [];
    });
    _graphWidget.replaceGraphModel(_buildGraphModel());
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.widthOf(context) <= GSettings.maxPhoneWidth;
    final sidePadding = isMobile ? 8.0 : 16.0;
    final topPadding = isMobile ? 8.0 : 16.0 + 64;
    final bottomPadding = isMobile ? 8.0 : 16.0;
    final rightPadding = isMobile ? 8.0 : GSettings.maxDialogWidth + 16 + 16;
    final maxDialogWidth = isMobile ? double.infinity : GSettings.maxDialogWidth;

    final infoCard = SixthLevelInfo(
      title: context.t.strings.levels.k6.stages.k1.title,
      richText: context.t.strings.levels.k6.stages.k1.richText(
        greenNode: (text) => TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green),
        ),
        orangeNode: (text) => TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.orange),
        ),
      ),
      onAnimationStartClick: _startBfsAnimation,
      onAnimationStopClick: _stopBfsAnimation,
      canStart: !_isAnimating,
      canStop: _isAnimating,
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
              child: GameWidget(game: _graphWidget),
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
