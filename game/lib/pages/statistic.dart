import 'package:flutter/material.dart';

import '../features/statistics/ui/statistics_screen.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: StatisticsScreen());
  }
}
