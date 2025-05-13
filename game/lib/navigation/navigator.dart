import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';
import 'routes_name.dart';

final class AppNavigator {
  static final BuildContext _context = rootNavigatorKey.currentContext!;

  AppNavigator._();

  static void openHome() {
    _context.goNamed(RoutesName.home.name);
  }

  static void openLevels() {
    _context.goNamed(RoutesName.levels.name);
  }

  static void openStatistic() {
    _context.goNamed(RoutesName.statistic.name);
  }

  static void openSettings() {
    _context.goNamed(RoutesName.settings.name);
  }
}
