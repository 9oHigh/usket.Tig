import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tig/core/manager/shared_preference_manager.dart';
import 'package:tig/core/routes/app_navigator.dart';
import 'package:tig/generated/l10n.dart';
import 'package:tig/ads/admob_service.dart';
import 'package:tig/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tig/presentation/widgets/styles/fixed_scroll_behavior.dart';
import 'firebase_options.dart';
import 'package:home_widget/home_widget.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceManager().initialize();
  await HomeWidget.registerInteractivityCallback(backgroundCallback);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));
  runApp(
    const ProviderScope(
      child: TigApp(),
    ),
  );
}

Future<void> backgroundCallback(Uri? uri) async {
  // MARK: - 위젯 클릭시 홈화면 이동 추가
}

class TigApp extends StatefulWidget {
  const TigApp({super.key});

  @override
  State<TigApp> createState() => _TigAppState();
}

class _TigAppState extends State<TigApp> {
  BannerAd? _bannerAd;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late bool _loginStatus;

  @override
  void initState() {
    super.initState();
    _loginStatus = _checkLoginStatus();
    _initGoogleMobileAds();
    _removeSplash();
    _setHomeArrangeStatus();
    _createBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  bool _checkLoginStatus() {
    bool isLoggedIn =
        SharedPreferenceManager().getPref<bool>(PrefsType.isLoggedIn) ?? false;
    final user = FirebaseAuth.instance.currentUser;
    return user != null && isLoggedIn;
  }

  Future<void> _initGoogleMobileAds() async {
    await MobileAds.instance.initialize();
  }

  Future<void> _removeSplash() async {
    await Future.delayed(const Duration(milliseconds: 1250));
    FlutterNativeSplash.remove();
  }

  void _setHomeArrangeStatus() {
    final bool? isOnDaily =
        SharedPreferenceManager().getPref<bool>(PrefsType.isOnDaily);
    final bool? isOnBraindump =
        SharedPreferenceManager().getPref<bool>(PrefsType.isOnBraindump);
    if (isOnDaily == null && isOnBraindump == null) {
      SharedPreferenceManager().setPref<bool>(PrefsType.isOnDaily, true);
      SharedPreferenceManager().setPref<bool>(PrefsType.isOnBraindump, true);
    }
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
          behavior: FixedScrollBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(fontLocale),
      darkTheme: buildDarkTheme(fontLocale),
      themeMode: ThemeMode.system,
      home: _loginStatus
          ? const Center(child: CircularProgressIndicator())
          : AppNavigator(
              navigatorKey: _navigatorKey,
              bannerAd: _bannerAd,
              isLoggedIn: _loginStatus,
            ),
    );
  }
}
