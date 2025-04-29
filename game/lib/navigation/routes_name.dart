final class RoutesName {
  RoutesName._();

  static Route home = Route('/home', 'home');
}

final class Route {
  final String path;
  final String name;

  Route(this.path, this.name);
}
