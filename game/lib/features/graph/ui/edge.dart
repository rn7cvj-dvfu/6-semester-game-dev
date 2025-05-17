
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'node.dart';
import 'widget.dart';

class ConnectingEdgeComponent extends Component
    with TapCallbacks, HoverCallbacks, HasGameReference<GraphWidget> {
  final NodeComponent from;
  final NodeComponent to;
  final Color color;
  final Color blendColor;

  final VoidCallback? onClick;

  ConnectingEdgeComponent({
    required this.from,
    required this.to,
    required this.color,
    required this.blendColor,
    this.onClick,
    super.priority = 0,
  });

  bool _isHovered = false;

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
      ..color = _isHovered ? Colors.red : color
      ..style = PaintingStyle.fill;

    const curveFactor = 20.0; // Adjust for more or less curve

    final path = Path()..moveTo(p1.x, p1.y);

    final cp1 = (p1 + p2) / 2 - perpendicular * curveFactor;
    path.quadraticBezierTo(cp1.x, cp1.y, p2.x, p2.y);

    path.lineTo(p3.x, p3.y);

    final cp2 = (p3 + p4) / 2 + perpendicular * curveFactor;
    path.quadraticBezierTo(cp2.x, cp2.y, p4.x, p4.y);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onClick?.call();
  }

  @override
  void onHoverEnter() {
    _isHovered = true;
  }

  @override
  void onHoverExit() {
    _isHovered = false;
  }
}
