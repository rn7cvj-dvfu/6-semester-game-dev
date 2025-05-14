import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';

import '../bloc/model.dart';
import 'connecting_edge.dart';
import 'dot.dart';

class GraphWidget extends FlameGame {
  final GraphModel graphModel;

  final Color backgroundColorValue;
  final Color dotColorValue;
  final Color connectionEdgeColorValue;

  // late DotComponent dot1;
  // late DotComponent dot2;

  GraphWidget({
    required this.graphModel,
    required this.backgroundColorValue,
    required this.dotColorValue,
    required this.connectionEdgeColorValue,
  });

  @override
  Color backgroundColor() => backgroundColorValue;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final dotsCount = graphModel.adjacencyMatrix.length;
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
        );
      },
    );

    final edges = <ConnectingEdgeComponent>[];

    for (var i = 0; i < dotsCount; i++) {
      for (var j = 0; j < dotsCount; j++) {
        if (i == j) continue;

        if (graphModel.adjacencyMatrix[i][j] != 1) continue;

        edges.add(
          ConnectingEdgeComponent(
            from: dots[i],
            to: dots[j],
            color: connectionEdgeColorValue,
          ),
        );
      }
    }

    addAll([...dots, ...edges]);
  }
}
