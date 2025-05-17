import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'widget.dart';

class NodeComponent extends PositionComponent
    with
        DragCallbacks,
        HoverCallbacks,
        TapCallbacks,
        HasGameReference<GraphWidget> {
  final String id;

  final Color color;
  final Color blendColor;
  final double radius;

  bool _dragging = false;
  bool _isHovered = false;

  final bool movable;

  final VoidCallback? onClick;

  NodeComponent({
    required this.id,
    required this.color,
    required this.blendColor,
    required this.radius,
    required Vector2 position,
    this.movable = true,
    this.onClick,
    super.priority = 1,
  }) {
    this.position = position;
    size = Vector2.all(radius * 2);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = _isHovered ? Color.lerp(color, blendColor, 0.5)! : color;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (!movable) {
      return;
    }

    _dragging = true;
    event.continuePropagation = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!movable) {
      return;
    }
    if (_dragging) {
      position += event.deviceDelta;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (!movable) {
      return;
    }
    _dragging = false;
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _dragging = false;
  }

  @override
  void onHoverEnter() {
    if (!movable && onClick == null) {
      return;
    }

    if (onClick == null) {
      return;
    }

    _isHovered = true;
  }

  @override
  void onHoverExit() {
    if (!movable && onClick == null) {
      return;
    }

    if (onClick == null) {
      return;
    }

    _isHovered = false;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onClick?.call();
  }
}
