import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:tig/core/di/injector.dart';
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
  provideDataSources();
  provideRepositories();
  provideUseCases();
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
  late Future<bool> _loginStatus;

  @override
  void initState() {
    super.initState();
    _loginStatus = _checkLoginStatus();
    _initGoogleMobileAds();
    _removeSplash();
    _setOptionStatus();
    _createBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<bool> _checkLoginStatus() async {
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

  void _setOptionStatus() {
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
    AdSize adSize =
        AdSize(width: size.width.truncate(), height: AdSize.fullBanner.height);

    _bannerAd = BannerAd(
      size: adSize,
      adUnitId: AdMobService.bannerAdUnitId ?? '',
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    FontLocale fontLocale = {
          'de': FontLocale.de,
          'en': FontLocale.en,
          'es': FontLocale.es,
          'ja': FontLocale.ja,
          'ko': FontLocale.ko,
          'pt': FontLocale.pt,
          'fr': FontLocale.fr,
          'zh_CN': FontLocale.zh_CN,
          'zh_TW': FontLocale.zh_TW,
        }[locale.languageCode == 'zh'
            ? 'zh_${locale.countryCode ?? 'CN'}'
            : locale.languageCode] ??
        FontLocale.en;
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) => ScrollConfiguration(
        behavior: FixedScrollBehavior(),
        child: child!,
      ),
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
            return AppNavigator(
              navigatorKey: _navigatorKey,
              bannerAd: _bannerAd,
              isLoggedIn: isLoggedIn,
            );
          }
        },
      ),
    );
  }
}
