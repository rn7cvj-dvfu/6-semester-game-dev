import 'package:flutter/material.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../../graph/ui/info_card.dart';

class SixthLevelInfo extends StatefulWidget {
  final int initialStageIndex;
  final int totalStages;

  final String title;
  final String? text;
  final TextSpan? richText;

  final void Function() onAnimationStartClick;

  const SixthLevelInfo({
    super.key,
    required this.title,
    this.initialStageIndex = 0,
    this.totalStages = 3,
    this.text,
    this.richText,
    required this.onAnimationStartClick,
  });

  @override
  State<SixthLevelInfo> createState() => _SixthLevelInfoState();
}

class _SixthLevelInfoState extends State<SixthLevelInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

          ElevatedButton(
            onPressed: widget.onAnimationStartClick,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // как у Card
              ),
            ),
            child: Text(context.t.strings.common.playAnimation),
          ),
        ],
      ),
    );
  }
}
