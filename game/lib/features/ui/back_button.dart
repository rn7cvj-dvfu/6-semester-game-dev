import 'package:flutter/material.dart';

import '../../.gen/i18n/strings.g.dart';

class GBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const GBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      label: Text(context.t.strings.common.back),
      icon: const Icon(Icons.arrow_back_ios_new),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    // return Card(
    //   clipBehavior: Clip.antiAlias,
    //   child: InkWell(
    //     onTap: onTap,
    //     child: Padding(
    //       padding: EdgeInsets.all(8),
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Icon(Icons.arrow_back_ios_new, size: 16),
    //           Text(context.t.strings.common.back),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
