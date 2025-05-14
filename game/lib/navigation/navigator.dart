import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'path_name.dart';
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

  static void openLevel(int levelId) {
    _context.goNamed(RoutesName.level.name, pathParameters: {
      PathName.levelId: levelId.toString(),
    });
  }

  static void openStatistic() {
    _context.goNamed(RoutesName.statistic.name);
  }

  static void openSettings() {
    _context.goNamed(RoutesName.settings.name);
  }
}
