import 'package:animations/animations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AnimatedBranchContainer extends StatefulWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  State<AnimatedBranchContainer> createState() =>
      _AnimatedBranchContainerState();
}

class _AnimatedBranchContainerState extends State<AnimatedBranchContainer>
    with TickerProviderStateMixin {
  final List<(AnimationController, AnimationController)> _controllers = [];
  @override
  void initState() {
    for (var i = 0; i < widget.children.length; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
      final controller2 = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
      if (i == widget.currentIndex) {
        controller.value = 1;
      }
      _controllers.add((controller, controller2));
    }

    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedBranchContainer oldWidget) {
    switch (widget.currentIndex.compareTo(oldWidget.currentIndex)) {
      case 1:
        _controllers[oldWidget.currentIndex].$2.forward();

        _controllers[widget.currentIndex].$2.value = 0;
        _controllers[widget.currentIndex].$1.forward(from: 0);

        break;
      case -1:
        _controllers[oldWidget.currentIndex].$1.reverse();

        _controllers[widget.currentIndex].$1.value = 1;
        _controllers[widget.currentIndex].$2.reverse(from: 1);
        break;
      default:
        break;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // return PageTransitionSwitcher(
    //   transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
    //     return SharedAxisTransition(
    //       animation: primaryAnimation,
    //       secondaryAnimation: secondaryAnimation,
    //       transitionType: SharedAxisTransitionType.horizontal,
    //       fillColor: Theme.of(context).colorScheme.surface,
    //       child: child,
    //     );
    //   },
    //   child: _branchNavigatorWrapper(
    //     widget.currentIndex,
    //     widget.children[widget.currentIndex],
    //   ),
    // );

    return Stack(
      children: widget.children.mapIndexed(
        (int index, Widget navigator) {
          return _branchNavigatorWrapper(
            index,
            RepaintBoundary(
              child: SharedAxisTransition(
                animation: _controllers[index].$1,
                secondaryAnimation: _controllers[index].$2,
                transitionType: SharedAxisTransitionType.horizontal,
                fillColor: Colors.transparent,
                child: navigator,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != widget.currentIndex,
        child: TickerMode(
          enabled: index == widget.currentIndex,
          child: navigator,
        ),
      );
}
