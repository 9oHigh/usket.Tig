class AppRoute {
  static const String home = '/home';
  static const String arrange = '/arrange';
  static const String auth = '/auth';

  static String? getRoute(String routeName) {
    switch (routeName) {
      case '/auth':
        return auth;
      case '/home':
        return home;
      case '/arrange':
        return arrange;
      default:
        return null;
    }
  }
}
