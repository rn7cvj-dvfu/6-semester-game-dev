import 'package:flutter/material.dart';

import '../features/settings.dart';
import '../features/statistics/ui/statistics_widget.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox.square(
          dimension: GSettings.maxDialogWidth,
          child: StatisticsWidget(),
        ),
      ),
    );
  }
}
