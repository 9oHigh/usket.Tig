import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tig/core/ads/admob_banner.dart';
import 'package:tig/core/routes/app_route.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/page/auth/auth_screen.dart';
import 'package:tig/presentation/page/option/option_screen.dart';
import 'package:tig/presentation/page/home/home_screen.dart';
import 'package:tig/presentation/page/menu/menu_screen.dart';
import 'package:tig/presentation/page/tag/tag_screen.dart';
import 'package:tig/presentation/page/tig_mode/tig_mode_screen.dart';

class AppNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey;
  final BannerAd? _bannerAd;
  final bool _isLoggedIn;

  const AppNavigator({
    super.key,
    required GlobalKey<NavigatorState> navigatorKey,
    required BannerAd? bannerAd,
    required bool isLoggedIn,
  })  : _navigatorKey = navigatorKey,
        _bannerAd = bannerAd,
        _isLoggedIn = isLoggedIn;

  bool _onWillPop() => _navigatorKey.currentState?.canPop() ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          final bool allowed = _onWillPop();
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
              case AppRoute.option:
                return CupertinoPageRoute(
                  builder: (_) => const OptionScreen(),
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
