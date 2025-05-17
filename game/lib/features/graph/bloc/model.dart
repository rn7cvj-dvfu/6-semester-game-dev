import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../.gen/features/graph/bloc/model.freezed.dart';

@freezed
class GraphModel with _$GraphModel {
  factory GraphModel({
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    @Default(false) bool edgeColorLerp,
    @Default(false) bool movable,
    @Default(false) bool clickable,
    @Default(false) bool possibleEdgeClickable,
  }) = _GraphModel;

  factory GraphModel.fromAdjacencyMatrix(
    List<List<int>> matrix, {
    bool movable = false,
    bool clickable = false,
    bool edgeColorLerp = false,
    bool possibleEdgeClickable = false,
    Color? Function(int nodeIndex)? nodeColor,
    Color? Function(int firstNodeIndex, int secondNodeIndex)? edgeColor,
  }) {
    final nodes = <NodeModel>[];
    final edges = <EdgeModel>[];

    for (int i = 0; i < matrix.length; i++) {
      nodes.add(NodeModel(id: 'node_$i', preferredColor: nodeColor?.call(i)));
    }

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == 0) {
          // Skip if there is no edge
          continue;
        }

        if (j <= i) {
          // Skip if the edge is already added
          continue;
        }

        edges.add(
          EdgeModel(
            id: 'edge_${i}_$j',
            firstNodeId: 'node_$i',
            secondNodeId: 'node_$j',
            preferredColor: edgeColor?.call(i, j),
          ),
        );
      }
    }
    return GraphModel(
      nodes: nodes,
      edges: edges,
      edgeColorLerp: edgeColorLerp,
      movable: movable,
      clickable: clickable,
      possibleEdgeClickable: possibleEdgeClickable,
    );
  }
}

@freezed
class NodeModel with _$NodeModel {
  factory NodeModel({
    required String id,
    // (0, 0) - screen center
    (double x, double y)? preferredPosition,
    Color? preferredColor,
  }) = _NodeModel;
}

@freezed
class EdgeModel with _$EdgeModel {
  factory EdgeModel({
    required String id,
    required String firstNodeId,
    required String secondNodeId,
    Color? preferredColor,
  }) = _EdgeModel;
}
