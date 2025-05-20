import 'package:flutter/material.dart';

import '../widgets/info_card.dart';

class FifthLevelInfo extends StatefulWidget {
  final String title;
  final String? text;
  final TextSpan? richText;

  const FifthLevelInfo({
    super.key,
    required this.title,
    this.text,
    this.richText,
  });

  @override
  State<FifthLevelInfo> createState() => _FifthLevelInfoState();
}

class _FifthLevelInfoState extends State<FifthLevelInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        InfoCardWidget(
          title: widget.title,
          text: widget.text,
          richText: widget.richText,
        ),
      ],
    );
  }
}
