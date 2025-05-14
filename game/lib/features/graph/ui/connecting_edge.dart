import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'dot.dart';

class ConnectingEdgeComponent extends Component {
  final DotComponent from;
  final DotComponent to;
  final Color color;

  ConnectingEdgeComponent({
    required this.from,
    required this.to,
    required this.color,
    super.priority = 0,
  });

  @override
  void render(Canvas canvas) {
    final beginCenter = from.position;
    final endCenter = to.position;

    final beginRadius = from.radius;
    final endRadius = to.radius;

    final direction = (endCenter - beginCenter).normalized();
    final perpendicular = Vector2(-direction.y, direction.x).normalized();

    final p1 = beginCenter + perpendicular * beginRadius;
    final p2 = endCenter + perpendicular * endRadius;
    final p3 = endCenter - perpendicular * endRadius;
    final p4 = beginCenter - perpendicular * beginRadius;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(p1.x, p1.y)
      ..lineTo(p2.x, p2.y)
      ..lineTo(p3.x, p3.y)
      ..lineTo(p4.x, p4.y)
      ..close();

    canvas.drawPath(path, paint);
  }
}
