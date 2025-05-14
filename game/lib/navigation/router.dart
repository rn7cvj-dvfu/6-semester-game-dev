import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home.dart';
import '../pages/level.dart';
import '../pages/levels.dart';
import '../pages/settings.dart';
import '../pages/statistic.dart';
import 'fade_transition.dart';
import 'path_name.dart';
import 'routes_name.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  initialLocation: RoutesName.home.path,
  routerNeglect: true,
  navigatorKey: rootNavigatorKey,
  routes: [
    // // НЕ УБИРАТЬ ЭТОТ РОУТ, ОН НУЖЕН ДЛЯ РАБОТЫ СНЭКОВ
    // ShellRoute(
    //   parentNavigatorKey: rootNavigatorKey,
    //   navigatorKey: shellNavigatorKey,
    //   builder: (context, state, child) => child,
    //   routes: [
    GoRoute(
      path: "${RoutesName.level.path}/:${PathName.levelId}",
      name: RoutesName.level.name,
      redirect: (context, state) {
        final redirectPath =
            "${RoutesName.home.path}/${RoutesName.levels.path}";

        final levelId = state.pathParameters[PathName.levelId];
        if (levelId == null) {
          return redirectPath;
        }
        if (int.tryParse(levelId) == null) {
          return redirectPath;
        }
        return null;
      },
      pageBuilder: (context, state) {
        final levelId = state.pathParameters[PathName.levelId]!;

        return FadeTransitionPage(
          child: LevelPage(
            levelId: int.parse(levelId),
          ),
        );
      },
    ),
    GoRoute(
      path: RoutesName.home.path,
      name: RoutesName.home.name,
      pageBuilder: (context, state) => FadeTransitionPage(
        child: HomePage(),
      ),
      routes: [
        GoRoute(
          path: RoutesName.levels.path,
          name: RoutesName.levels.name,
          pageBuilder: (context, state) => FadeTransitionPage(
            child: LevelsPage(),
          ),
        ),
        GoRoute(
          path: RoutesName.statistic.path,
          name: RoutesName.statistic.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: StatisticPage(),
          ),
        ),
        GoRoute(
          path: RoutesName.settings.path,
          name: RoutesName.settings.name,
          pageBuilder: (context, state) => MaterialPage(
            fullscreenDialog: true,
            child: SettingsPage(),
          ),
        ),
      ],
    )
    // ],
    // ),
  ],
);
