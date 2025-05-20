import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/models/model.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/level/ui/layouts/desktop.dart';
import '../../features/level/ui/layouts/mobile.dart';
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
  GraphWidget? _graphWidget;

  @override
  void initState() {
    super.initState();
    // Цвета будут заданы в build
  }

  void _ensureGraphWidget(BuildContext context) {
    if (_graphWidget == null) {
      _graphWidget = GraphWidget(
        graphModel: _buildGraphModel(),
        backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
        nodeColorValue: Theme.of(context).colorScheme.primary,
        edgeColorValue: Theme.of(context).colorScheme.primaryContainer,
        onNodeClick: _onNodeClick,
        onEdgeClick: (_) {},
      );
    }
  }

  GraphModel _buildGraphModel() {
    // 1. Подсветка вершин пути
    final nodes = _nodes.map((node) {
      Color? color;
      if (node.id == _currentNodeId) {
        color = Colors.red;
      } else if (node.id == _endNodeId) {
        color = Colors.blue;
      } else if (_userPath.contains(node.id)) {
        color = Colors.green.shade200;
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

    // 2. Подсветка рёбер пути
    final pathEdges = <String>{};
    for (int i = 0; i < _userPath.length - 1; i++) {
      final from = _userPath[i];
      final to = _userPath[i + 1];
      final edge = _edges.firstWhereOrNull(
        (e) =>
            (e.firstNodeId == from && e.secondNodeId == to) ||
            (e.firstNodeId == to && e.secondNodeId == from),
      );
      if (edge != null) pathEdges.add(edge.id);
    }
    final edges = _edges.map((e) {
      if (pathEdges.contains(e.id)) {
        return e.copyWith(preferredColor: Colors.green);
      }
      return e;
    }).toList();

    return GraphModel(nodes: nodes, edges: edges, clickable: true);
  }

  void _updateGraph(BuildContext context) {
    if (_graphWidget != null) {
      _graphWidget!.replaceGraphModel(_buildGraphModel());
    }
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

    final prevIndex = _userPath.length > 1 ? _userPath.length - 2 : null;

    // Если клик по предыдущей вершине — откатиться назад
    if (prevIndex != null && _userPath[prevIndex] == nodeId) {
      setState(() {
        _userPath.removeLast();
        _currentNodeId = nodeId;
        _updateGraph(context);
      });
      return;
    }

    // Если клик по соседу, которого ещё нет в пути — добавить
    if (neighbors.contains(nodeId) && !_userPath.contains(nodeId)) {
      setState(() {
        _currentNodeId = nodeId;
        _userPath.add(nodeId);
        _updateGraph(context);
      });

      if (nodeId == _endNodeId) {
        showFinishLevelDialog(context, 6);
      }
    }
  }

  void _onBackStep(BuildContext context) {
    if (_userPath.length > 1) {
      setState(() {
        _userPath.removeLast();
        _currentNodeId = _userPath.last;
        _updateGraph(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _ensureGraphWidget(context);
    final isMobile = MediaQuery.widthOf(context) <= GSettings.maxPhoneWidth;

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

    final backButton = GBackButton(onTap: AppNavigator.openLevels);

    return switch (isMobile) {
      true => MobileLayout(
        graphWidget: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GameWidget(game: _graphWidget!),
        ),
        infoCard: infoCard,
        backButton: backButton,
      ),
      false => DesktopLayout(
        graphWidget: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GameWidget(game: _graphWidget!),
        ),
        infoCard: infoCard,
        backButton: backButton,
      ),
    };
  }
}
