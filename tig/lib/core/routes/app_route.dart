class AppRoute {
  static const String home = '/home';
  static const String arrange = '/arrange';
  static const String auth = '/auth';
  static const String tigMode = '/tigMode';
  static const String menu = '/menu';

  static String? getRoute(String routeName) {
    switch (routeName) {
      case '/auth':
        return auth;
      case '/home':
        return home;
      case '/arrange':
        return arrange;
      case '/tigMode':
        return tigMode;
      case '/menu':
        return menu;
      default:
        return null;
    }
  }
}
