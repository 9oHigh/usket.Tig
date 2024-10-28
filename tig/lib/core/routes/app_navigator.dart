import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tig/ads/admob_banner.dart';
import 'package:tig/core/routes/app_route.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/screens/auth/auth_screen.dart';
import 'package:tig/presentation/screens/home/home_arrange_screen.dart';
import 'package:tig/presentation/screens/home/home_screen.dart';
import 'package:tig/presentation/screens/menu/menu_screen.dart';
import 'package:tig/presentation/screens/tag/tag_screen.dart';
import 'package:tig/presentation/screens/tig_mode/tig_mode_screen.dart';

class AppScreenNavigator extends StatelessWidget {
  const AppScreenNavigator({
    required GlobalKey<NavigatorState> navigatorKey,
    required BannerAd? bannerAd,
    required bool isLoggedIn,
  })  : _navigatorKey = navigatorKey,
        _bannerAd = bannerAd,
        _isLoggedIn = isLoggedIn;

  final GlobalKey<NavigatorState> _navigatorKey;
  final BannerAd? _bannerAd;
  final bool _isLoggedIn;

  bool _onWillPop() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          final allowed = _onWillPop();
          if (allowed) {
            _navigatorKey.currentState?.pop();
          }
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: _isLoggedIn ? AppRoute.home : AppRoute.auth,
          onGenerateRoute: (RouteSettings settings) {
            var route = AppRoute.getRoute(settings.name!);
            final arguments = settings.arguments;
            switch (route) {
              case AppRoute.auth:
                return CupertinoPageRoute(
                  builder: (_) => const AuthScreen(),
                  settings: settings,
                );
              case AppRoute.home:
                return CupertinoPageRoute(
                  builder: (_) => const HomeScreen(),
                  settings: settings,
                );
              case AppRoute.arrange:
                return CupertinoPageRoute(
                  builder: (_) => const HomeArrangeScreen(),
                  settings: settings,
                );
              case AppRoute.tigMode:
                if (arguments is Tig) {
                  return CupertinoPageRoute(
                    builder: (_) => TigModeScreen(
                      tig: arguments,
                    ),
                    settings: settings,
                  );
                }
              case AppRoute.menu:
                return CupertinoPageRoute(
                  builder: (_) => const MenuScreen(),
                  settings: settings,
                );
              case AppRoute.tag:
                return CupertinoPageRoute(
                  builder: (_) => const TagScreen(),
                  settings: settings,
                );
              default:
                return null;
            }
            return null;
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: AdmobBanner(
          bannerAd: _bannerAd,
        ),
      ),
    );
  }
}
