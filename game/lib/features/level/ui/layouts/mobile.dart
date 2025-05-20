import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  final Widget graphWidget;
  final Widget infoCard;
  final Widget backButton;

  const MobileLayout({
    super.key,
    required this.graphWidget,
    required this.infoCard,
    required this.backButton,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: backButton,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(child: graphWidget),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: infoCard,
            ),
          ],
        ),
      ),
    );
  }
}
