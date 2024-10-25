import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tig/ads/admob_service.dart';
import 'package:tig/core/helpers/helpers.dart';
import 'package:tig/core/theme/app_theme.dart';
import 'package:tig/generated/l10n.dart';
import 'package:tig/core/routes/app_navigator.dart';

class SubscribedTigApp extends StatefulWidget {
  const SubscribedTigApp({super.key});

  @override
  State<SubscribedTigApp> createState() => SubscribedTigAppState();
}

class SubscribedTigAppState extends State<SubscribedTigApp> {
  BannerAd? _bannerAd;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late Future<bool> _loginStatus;

  @override
  void initState() {
    super.initState();
    _loginStatus = _checkLoginStatus();
    _initGoogleMobileAds();
    _createBannerAd();
    _setHomeArrangeStatus();
    _removeSplash();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  Future<void> _removeSplash() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLoggedIn = pref.getBool("isLoggedIn") ?? false;
    final user = FirebaseAuth.instance.currentUser;
    return user != null && isLoggedIn;
  }

  Future<void> _setHomeArrangeStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final bool? isOnDaily = pref.getBool("isOnDaily");
    final bool? isOnBraindump = pref.getBool("isOnBraindump");
    if (isOnDaily == null && isOnBraindump == null) {
      pref.setBool("isOnDaily", true);
      pref.setBool("isOnBraindump", true);
    }
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

  @override
  Widget build(BuildContext context) {
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
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
            return AppScreenNavigator(
              navigatorKey: _navigatorKey,
              bannerAd: _bannerAd,
              isLoggedIn: isLoggedIn,
              isSubscribed: true,
            );
          }
        },
      ),
    );
  }
}
