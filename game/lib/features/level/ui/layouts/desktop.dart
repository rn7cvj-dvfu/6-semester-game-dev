import 'package:flutter/material.dart';

import '../../../settings.dart';

class DesktopLayout extends StatelessWidget {
  final Widget graphWidget;
  final Widget infoCard;
  final Widget backButton;

  const DesktopLayout({
    super.key,
    required this.graphWidget,
    required this.infoCard,
    required this.backButton,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16 + GSettings.maxDialogWidth,
                bottom: 16,
              ),
              child: Center(child: graphWidget),
            ),
          ),
          Positioned(top: 16, left: 16, child: backButton),
          Positioned(
            top: 0,
            right: 16,
            bottom: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: GSettings.maxDialogWidth),
              child: SingleChildScrollView(
                primary: false,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: infoCard,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
