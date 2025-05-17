import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../bloc/model.dart';
import 'edge.dart';
import 'node.dart';

class GraphWidget extends FlameGame {
  final GraphModel graphModel;

  final void Function(String nodeId) onNodeClick;
  final void Function(String edgeId) onEdgeClick;
  final void Function(String firstNodeId, String secondNodeId)?
  onPossibleEdgeClick;

  final Color backgroundColorValue;
  final Color nodeColorValue;
  final Color edgeColorValue;

  GraphWidget({
    required this.graphModel,
    required this.onNodeClick,
    required this.onEdgeClick,
    this.onPossibleEdgeClick,
    required this.backgroundColorValue,
    required this.nodeColorValue,
    required this.edgeColorValue,
  }) {
    final nodesIds = graphModel.nodes.map((e) => e.id).toList();
    final edgesIds = graphModel.edges.map((e) => e.id).toList();

    final edgesNodesIds = graphModel.edges
        .map((e) => [e.firstNodeId, e.secondNodeId])
        .fold(<String>[], (previousValue, element) {
          previousValue.addAll(element);
          return previousValue;
        })
        .toList();

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
    final radius = min(size.x, size.y) / 3;

    final nodes = List<NodeComponent>.generate(dotsCount, (index) {
      final node = graphModel.nodes[index];

      final angle = (2 * pi * index) / dotsCount;
      double x = center.x + radius * cos(angle);
      double y = center.y + radius * sin(angle);

      if (node.preferredPosition != null) {
        x = node.preferredPosition!.$1 * size.x / 2 + center.x;
        y = node.preferredPosition!.$2 * size.y / 2 + center.y;
      }

      return NodeComponent(
        id: node.id,
        color: node.preferredColor ?? nodeColorValue,
        blendColor: edgeColorValue,
        radius: 20,
        position: Vector2(x, y),
        movable: graphModel.movable,
        onClick: graphModel.clickable ? () => onNodeClick(node.id) : null,
      );
    });

    final edgesCount = graphModel.edges.length;
    final edges = <ConnectingEdgeComponent>[];

    for (var i = 0; i < edgesCount; i++) {
      final edge = graphModel.edges[i];
      final firstNodeIndex = graphModel.nodes.indexWhere(
        (element) => element.id == edge.firstNodeId,
      );
      final secondNodeIndex = graphModel.nodes.indexWhere(
        (element) => element.id == edge.secondNodeId,
      );

      final firstDot = nodes[firstNodeIndex];
      final firstNode = graphModel.nodes[firstNodeIndex];

      final secondDot = nodes[secondNodeIndex];
      final secondNode = graphModel.nodes[secondNodeIndex];

      final firstNodeColor = firstNode.preferredColor;
      final secondNodeColor = secondNode.preferredColor;

      Color edgeColor = edgeColorValue;

      if ((firstNodeColor != null || secondNodeColor != null) &&
          graphModel.edgeColorLerp) {
        final tempColor = Color.lerp(
          firstNodeColor ?? nodeColorValue,
          secondNodeColor ?? nodeColorValue,
          0.5,
        )!;
        edgeColor = Color.lerp(edgeColor, tempColor, 0.9)!;
      }

      final edgeComponent = ConnectingEdgeComponent(
        color: edge.preferredColor ?? edgeColor,
        blendColor: edgeColorValue,
        from: firstDot,
        to: secondDot,
        onClick: graphModel.clickable ? () => onEdgeClick(edge.id) : null,
      );

      edges.add(edgeComponent);
    }

    addAll([...nodes, ...edges]);

    if (graphModel.clickable && graphModel.possibleEdgeClickable) {
      await _addPossibleEdges(nodes);
    }
  }

  Future<void> _addPossibleEdges(List<NodeComponent> nodes) async {
    final List<ConnectingEdgeComponent> possibleEdges = [];

    for (int i = 0; i < graphModel.nodes.length; i++) {
      for (int j = i + 1; j < graphModel.nodes.length; j++) {
        final firstNode = graphModel.nodes[i];
        final secondNode = graphModel.nodes[j];

        final fitFS = graphModel.edges.any(
          (e) =>
              e.firstNodeId == firstNode.id && e.secondNodeId == secondNode.id,
        );

        final fitSS = graphModel.edges.any(
          (e) =>
              e.firstNodeId == secondNode.id && e.secondNodeId == firstNode.id,
        );

        if (!fitFS && !fitSS) {
          final firstNodeComponent = nodes.firstWhere(
            (element) => element.id == firstNode.id,
          );
          final secondNodeComponent = nodes.firstWhere(
            (element) => element.id == secondNode.id,
          );
          possibleEdges.add(
            ConnectingEdgeComponent(
              color: edgeColorValue,
              blendColor: edgeColorValue,
              from: firstNodeComponent,
              to: secondNodeComponent,
              onClick: () => onPossibleEdgeClick?.call(
                firstNodeComponent.id,
                secondNodeComponent.id,
              ),
            ),
          );
        }
      }
    }

    addAll(possibleEdges);
  }
}
