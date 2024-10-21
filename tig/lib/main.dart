import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/ads/admob_banner.dart';
import 'package:tig/core/helpers/helpers.dart';
import 'package:tig/data/models/tig.dart';
import 'package:tig/generated/l10n.dart';
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
import 'package:tig/presentation/screens/tag/tag_screen.dart';
import 'package:tig/presentation/screens/tig_mode/tig_mode_screen.dart';
import 'firebase_options.dart';
import 'package:home_widget/home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HomeWidget.registerInteractivityCallback(backgroundCallback);
  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));
  runApp(
    const ProviderScope(
      child: TigApp(),
    ),
  );
}

Future<void> backgroundCallback(Uri? uri) async {}

class TigApp extends StatefulWidget {
  const TigApp({super.key});

  @override
  State<TigApp> createState() => _TigApp();
}

class _TigApp extends State<TigApp> {
  BannerAd? _bannerAd;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late Future<bool> _loginStatus;

  @override
  void initState() {
    super.initState();
    _loginStatus = _checkLoginStatus();
    _setHomeArrangeStatus();
    _initGoogleMobileAds();
    _createBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLoggedIn = pref.getBool("isLoggedIn") ?? false;
    final user = FirebaseAuth.instance.currentUser;
    return user != null && isLoggedIn;
  }

  _setHomeArrangeStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final bool? isOnDaily = pref.getBool("isOnDaily");
    final bool? isOnBraindump = pref.getBool("isOnBraindump");
    if (isOnDaily == null && isOnBraindump == null) {
      pref.setBool("isOnDaily", true);
      pref.setBool("isOnBraindump", true);
    }
  }

  void _rebuildOnLocaleChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    WidgetsBinding.instance.platformDispatcher.onLocaleChanged =
        _rebuildOnLocaleChange;
    FontLocale fontLocale;
    switch (locale.languageCode) {
      case 'de':
        fontLocale = FontLocale.de;
        break;
      case 'en':
        fontLocale = FontLocale.en;
        break;
      case 'es':
        fontLocale = FontLocale.es;
        break;
      case 'ja':
        fontLocale = FontLocale.ja;
        break;
      case 'ko':
        fontLocale = FontLocale.ko;
        break;
      case 'pt':
        fontLocale = FontLocale.pt;
        break;
      case 'zh':
        if (locale.countryCode == 'CN') {
          fontLocale = FontLocale.zh_CN;
        } else if (locale.countryCode == 'TW') {
          fontLocale = FontLocale.zh_TW;
        } else {
          fontLocale = FontLocale.zh_CN;
        }
        break;
      default:
        fontLocale = FontLocale.en;
    }
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: Helpers.fixedScrollBehavior,
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(fontLocale),
      darkTheme: buildDarkTheme(fontLocale),
      themeMode: ThemeMode.system,
      home: FutureBuilder<bool>(
        future: _loginStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                Intl.message(
                  'main_restart',
                  args: [(snapshot.error.toString())],
                ),
              ),
            );
          } else {
            final isLoggedIn = snapshot.data ?? false;
            return _TigScreenNavigator(
              navigatorKey: _navigatorKey,
              bannerAd: _bannerAd,
              isLoggedIn: isLoggedIn,
            );
          }
        },
      ),
    );
  }

  Future<void> _initGoogleMobileAds() async {
    await MobileAds.instance.initialize();
  }

  void _createBannerAd() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;
    AdSize adSize = AdSize(
      width: size.width.truncate(),
      height: AdSize.fullBanner.height,
    );
    _bannerAd = BannerAd(
      size: adSize,
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

  bool _onWillPop() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      return true;
    }
    return false;
  }
}
