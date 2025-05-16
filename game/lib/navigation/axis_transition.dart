import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AxisTransitionPage extends CustomTransitionPage {
  AxisTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.transitionDuration,
    super.key,
    Color? fillColor,
    SharedAxisTransitionType transitionType = SharedAxisTransitionType.vertical,
  }) : super(
         transitionsBuilder:
             (
               BuildContext context,
               Animation<double> animation,
               Animation<double> secondaryAnimation,
               Widget child,
             ) => SharedAxisTransition(
               transitionType: transitionType,
               animation: animation,
               secondaryAnimation: secondaryAnimation,
               fillColor: fillColor,
               child: child,
             ),
       );
}
