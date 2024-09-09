class AppRoute {
  static const String home = '/';
  static const String arrange = '/arrange';

  static String getRoute(String routeName) {
    switch (routeName) {
      case '/arrange':
        return arrange;
      case '/':
      default:
        return home;
    }
  }
}
