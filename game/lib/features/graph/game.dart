import 'dart:ui';

import 'package:flame/game.dart';

import 'connecting_edge.dart';
import 'dot.dart';

class GraphGame extends FlameGame {
  final Color backgroundColorValue;
  final Color dotColorValue;

  late DotComponent dot1;
  late DotComponent dot2;

  GraphGame({
    required this.backgroundColorValue,
    required this.dotColorValue,
  });

  @override
  Color backgroundColor() => backgroundColorValue;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    dot1 = DotComponent(
      color: dotColorValue,
      radius: 20,
      position: canvasSize / 2 + Vector2(-100, 0),
    );

    dot2 = DotComponent(
      color: dotColorValue,
      radius: 20,
      position: canvasSize / 2 + Vector2(100, 0),
    );

    final connectingEdge = ConnectingEdge(
      from: dot1,
      to: dot2,
      color: dotColorValue,
    );

    addAll([
      dot1,
      dot2,
      connectingEdge,
    ]);
  }
}
