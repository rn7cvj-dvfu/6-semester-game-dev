import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';

import '../bloc/model.dart';
import 'connecting_edge.dart';
import 'dot.dart';

class GraphWidget extends FlameGame {
  final GraphModel graphModel;

  final void Function(String nodeId) onNodeClick;
  final void Function(String edgeId) onEdgeClick;

  final Color backgroundColorValue;
  final Color dotColorValue;
  final Color connectionEdgeColorValue;

  // late DotComponent dot1;
  // late DotComponent dot2;

  GraphWidget({
    required this.graphModel,
    required this.onNodeClick,
    required this.onEdgeClick,
    required this.backgroundColorValue,
    required this.dotColorValue,
    required this.connectionEdgeColorValue,
  }) {
    final nodesIds = graphModel.nodes.map((e) => e.id).toList();
    final edgesIds = graphModel.edges.map((e) => e.id).toList();

    final edgesNodesIds = graphModel.edges
        .map((e) => [e.firstNodeId, e.secondNodeId])
        .fold(<String>[], (previousValue, element) {
      previousValue.addAll(element);
      return previousValue;
    }).toList();

    assert(
      nodesIds.length == nodesIds.toSet().length,
      'All nodes must have unique ids',
    );

    assert(
      edgesIds.length == edgesIds.toSet().length,
      'All edges must have unique ids',
    );

    assert(
      edgesNodesIds.every((element) => nodesIds.contains(element)),
      'All edges must be connected to existing nodes',
    );
  }

  @override
  Color backgroundColor() => backgroundColorValue;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final dotsCount = graphModel.nodes.length;
    final center = size / 2;
    final radius = min(size.x, size.y) / 2 - 200;

    final dots = List<DotComponent>.generate(
      dotsCount,
      (index) {
        final angle = (2 * pi * index) / dotsCount;
        final x = center.x + radius * cos(angle);
        final y = center.y + radius * sin(angle);

        return DotComponent(
          color: dotColorValue,
          blendColor: connectionEdgeColorValue,
          radius: 20,
          position: Vector2(x, y),
          movable: graphModel.movable,
          onClick: graphModel.clickable
              ? () => onNodeClick(graphModel.nodes[index].id)
              : null,
        );
      },
    );

    final edgesCount = graphModel.edges.length;
    final edges = <ConnectingEdgeComponent>[];

    for (var i = 0; i < edgesCount; i++) {
      final edge = graphModel.edges[i];
      final firstNodeIndex = graphModel.nodes
          .indexWhere((element) => element.id == edge.firstNodeId);
      final secondNodeIndex = graphModel.nodes
          .indexWhere((element) => element.id == edge.secondNodeId);

      final firstDot = dots[firstNodeIndex];
      final secondDot = dots[secondNodeIndex];

      final edgeComponent = ConnectingEdgeComponent(
        color: connectionEdgeColorValue,
        from: firstDot,
        to: secondDot,
        onClick: graphModel.clickable ? () => onEdgeClick(edge.id) : null,
      );

      edges.add(edgeComponent);
    }

    addAll([...dots, ...edges]);
  }
}
