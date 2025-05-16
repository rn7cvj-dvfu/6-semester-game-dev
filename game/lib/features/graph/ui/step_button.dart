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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onBack,
              child: Text(
                context.t.strings.common.back,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('${currentStage + 1} / $totalStages'),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: onNext,
              child: Text(
                currentStage == totalStages - 1
                    ? context.t.strings.common.finish
                    : context.t.strings.common.next,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
