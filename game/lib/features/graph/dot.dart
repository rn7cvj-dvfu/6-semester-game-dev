import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/services.dart';

import 'game.dart';

class DotComponent extends PositionComponent
    with DragCallbacks, HoverCallbacks, HasGameReference<GraphGame> {
  final Color color;
  final double radius;
  bool _dragging = false;
  bool _isHovered = false;

  DotComponent({
    required this.color,
    required this.radius,
    required Vector2 position,
  }) {
    this.position = position;
    size = Vector2.all(radius * 2);
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = _isHovered ? color.withValues(alpha: 0.7) : color;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _dragging = true;
    event.continuePropagation = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_dragging) {
      position += event.deviceDelta;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _dragging = false;
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _dragging = false;
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
