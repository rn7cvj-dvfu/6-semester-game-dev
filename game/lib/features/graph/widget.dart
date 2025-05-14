import 'dart:ui';

import 'package:flame/game.dart';

import 'connecting_edge.dart';
import 'dot.dart';

class GraphWidget extends FlameGame {
  final Color backgroundColorValue;
  final Color dotColorValue;
  final Color connectionEdgeColorValue;

  // late DotComponent dot1;
  // late DotComponent dot2;

  GraphWidget({
    required this.backgroundColorValue,
    required this.dotColorValue,
    required this.connectionEdgeColorValue,
  });

  @override
  Color backgroundColor() => backgroundColorValue;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final dot1 = DotComponent(
      color: dotColorValue,
      radius: 20,
      position: canvasSize / 2 + Vector2(-100, 0),
    );

    final dot2 = DotComponent(
      color: dotColorValue,
      radius: 20,
      position: canvasSize / 2 + Vector2(100, 0),
    );

    final dot3 = DotComponent(
      color: dotColorValue,
      radius: 20,
      position: canvasSize / 2 + Vector2(100, 50),
    );

    final dot4 = DotComponent(
      color: dotColorValue,
      radius: 20,
      position: canvasSize / 2 + Vector2(100, -50),
    );

    final connectingEdge12 = ConnectingEdgeComponent(
      from: dot1,
      to: dot2,
      color: connectionEdgeColorValue,
    );

    final connectingEdge23 = ConnectingEdgeComponent(
      from: dot2,
      to: dot3,
      color: connectionEdgeColorValue,
    );
    final connectingEdge34 = ConnectingEdgeComponent(
      from: dot3,
      to: dot4,
      color: connectionEdgeColorValue,
    );

    addAll([
      connectingEdge12,
      connectingEdge23,
      connectingEdge34,
      dot1,
      dot2,
      dot3,
      dot4,
    ]);
  }
}
