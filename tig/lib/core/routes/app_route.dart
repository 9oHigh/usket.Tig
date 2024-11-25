class AppRoute {
  static const String home = '/home';
  static const String option = '/option';
  static const String auth = '/auth';
  static const String tigMode = '/tigMode';
  static const String menu = '/menu';
  static const String tag = '/tag';

  static String? getRoute(String routeName) {
    switch (routeName) {
      case '/auth':
        return auth;
      case '/home':
        return home;
      case '/option':
        return option;
      case '/tigMode':
        return tigMode;
      case '/menu':
        return menu;
      case '/tag':
        return tag;
      default:
        return null;
    }
  }
}
