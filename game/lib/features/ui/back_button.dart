import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';

class GBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const GBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                size: 16,
              ),
              Text(
                t.strings.back,
              )
            ],
          ),
        ),
      ),
    );
  }
}
