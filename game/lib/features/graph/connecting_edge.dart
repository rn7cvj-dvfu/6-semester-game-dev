import 'dart:ui';

import 'package:flame/components.dart';

import 'dot.dart';

class ConnectingEdge extends Component {
  final DotComponent from;
  final DotComponent to;
  final Color color;

  ConnectingEdge({
    required this.from,
    required this.to,
    required this.color,
  });

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final fromPos = from.position;
    final toPos = to.position;

    final direction = (toPos - fromPos).normalized();
    final perpendicular = Vector2(-direction.y, direction.x);

    final startWidth = from.radius;
    final endWidth = to.radius;

    final startCenter = fromPos + direction * startWidth * 0.1;
    final endCenter = toPos - direction * endWidth * 0.1;

    final center = (startCenter + endCenter) / 2;
    final distance = (endCenter - startCenter).length;

    final p1 = startCenter + perpendicular * startWidth;
    final p2 = endCenter + perpendicular * endWidth;
    final p3 = endCenter - perpendicular * endWidth;
    final p4 = startCenter - perpendicular * startWidth;

    final controlOffset = (endCenter - startCenter) / 2;

    final curveStrength = 0.1;

    final cp1 = startCenter +
        controlOffset +
        perpendicular * startWidth * curveStrength;
    final cp2 = startCenter +
        controlOffset -
        perpendicular * startWidth * curveStrength;

    final path = Path()
      ..moveTo(p1.x, p1.y)
      ..quadraticBezierTo(cp1.x, cp1.y, p2.x, p2.y)
      ..lineTo(p3.x, p3.y)
      ..quadraticBezierTo(cp2.x, cp2.y, p4.x, p4.y)
      ..close();

    canvas.drawPath(path, paint);
  }
}
