import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/ads/admob_banner.dart';
import 'package:tig/core/helpers/helpers.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/presentation/screens/auth/auth_screen.dart';
import 'package:tig/presentation/screens/home/home_arrange_screen.dart';
import 'package:tig/presentation/screens/home/home_screen.dart';
import 'package:tig/ads/admob_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:tig/core/routes/app_route.dart';
import 'package:tig/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tig/presentation/screens/menu/menu_screen.dart';
import 'package:tig/presentation/screens/tig_mode/tig_mode_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: TigApp(),
    ),
  );
}

class TigApp extends StatefulWidget {
  const TigApp({super.key});

  @override
  State<TigApp> createState() => _TigApp();
}

class _TigApp extends State<TigApp> {
  BannerAd? _bannerAd;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _initGoogleMobileAds();
    _createBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    _isLoggedIn = user != null;
    if (user != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('userId', user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: Helpers.fixedScrollBehavior,
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: _TigScreenNavigator(
        navigatorKey: _navigatorKey,
        bannerAd: _bannerAd,
        isLoggedIn: _isLoggedIn,
      ),
    );
  }

  Future<void> _initGoogleMobileAds() async {
    await MobileAds.instance.initialize();
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId ?? '',
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }
}

class _TigScreenNavigator extends StatelessWidget {
  const _TigScreenNavigator({
    required GlobalKey<NavigatorState> navigatorKey,
    required BannerAd? bannerAd,
    required bool isLoggedIn,
  })  : _navigatorKey = navigatorKey,
        _bannerAd = bannerAd,
        _isLoggedIn = isLoggedIn;

  final GlobalKey<NavigatorState> _navigatorKey;
  final BannerAd? _bannerAd;
  final bool _isLoggedIn;

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

  bool _onWillPop() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      return true;
    }
    return false;
  }
}
