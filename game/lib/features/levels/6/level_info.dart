import 'package:flutter/material.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../../settings.dart';
import '../widgets/info_card.dart';

class SixthLevelInfo extends StatefulWidget {
  final int initialStageIndex;
  final int totalStages;

  final String title;
  final String? text;
  final TextSpan? richText;

  final bool canStart;
  final bool canStop;

  final void Function() onAnimationStartClick;
  final void Function() onAnimationStopClick;

  const SixthLevelInfo({
    super.key,
    required this.title,
    this.initialStageIndex = 0,
    this.totalStages = 3,
    this.text,
    this.richText,
    this.canStart = true,
    this.canStop = true,
    required this.onAnimationStartClick,
    required this.onAnimationStopClick,
  });

  @override
  State<SixthLevelInfo> createState() => _SixthLevelInfoState();
}

class _SixthLevelInfoState extends State<SixthLevelInfo> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: GSettings.maxDialogWidth),
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            InfoCardWidget(
              title: widget.title,
              text: widget.text,
              richText: widget.richText,
            ),

            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.canStart
                        ? widget.onAnimationStartClick
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // как у Card
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow),
                    label: Text(
                      context.t.strings.common.playAnimation,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.canStop
                        ? widget.onAnimationStopClick
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // как у Card
                      ),
                    ),
                    icon: const Icon(Icons.stop),
                    label: Text(
                      context.t.strings.common.stopAnimation,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
