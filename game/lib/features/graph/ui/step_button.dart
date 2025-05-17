import 'package:flutter/material.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../../settings.dart';

class StepButton extends StatelessWidget {
  final int currentStage;
  final int totalStages;

  final VoidCallback? onBack;
  final VoidCallback? onNext;

  const StepButton({
    super.key,
    required this.currentStage,
    required this.totalStages,
    this.onBack,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: GSettings.maxDialogWidth),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // как у Card
                  ),
                ),
                child: Text(context.t.strings.common.back),
              ),
            ),

            Card(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                alignment: Alignment.center,
                child: Text('${currentStage + 1} / $totalStages'),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // как у Card
                  ),
                ),
                child: Text(
                  currentStage == totalStages - 1
                      ? context.t.strings.common.finish
                      : context.t.strings.common.next,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
