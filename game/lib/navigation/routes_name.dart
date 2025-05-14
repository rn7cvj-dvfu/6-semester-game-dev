final class RoutesName {
  RoutesName._();

  static Route home = Route('/home', 'home');

  static Route level = Route('/level', 'level');

  static Route levels = Route('levels', 'levels');

  static Route statistic = Route('statistic', 'statistic');

  static Route settings = Route('settings', 'settings');
}

final class Route {
  final String path;
  final String name;

  Route(this.path, this.name);
}
