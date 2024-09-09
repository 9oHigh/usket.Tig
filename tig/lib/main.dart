import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tig/screens/home/home_arrange_screen.dart';
import 'package:tig/screens/home/home_screen.dart';
import 'package:tig/utils/remove_scroll_animation.dart';
import 'package:tig/services/admob_service.dart';
import 'package:flutter/cupertino.dart';

import 'utils/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  runApp(const TigApp());
}

class TigApp extends StatefulWidget {
  const TigApp({super.key});

  @override
  TigAppState createState() => TigAppState();
}

class TigAppState extends State<TigApp> {
  BannerAd? _bannerAd;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _initGoogleMobileAds();
    _createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveScrollAnimation(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: _HomeScreenNavigator(
        navigatorKey: _navigatorKey,
        bannerAd: _bannerAd,
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

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _HomeScreenNavigator extends StatelessWidget {
  const _HomeScreenNavigator({
    super.key,
    required GlobalKey<NavigatorState> navigatorKey,
    required BannerAd? bannerAd,
  })  : _navigatorKey = navigatorKey,
        _bannerAd = bannerAd;

  final GlobalKey<NavigatorState> _navigatorKey;
  final BannerAd? _bannerAd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          final route = AppRoute.getRoute(settings.name!);

          switch (route) {
            case AppRoute.arrange:
              return CupertinoPageRoute(
                builder: (_) => const HomeArrangeScreen(),
                settings: settings,
              );
            case AppRoute.home:
            default:
              return CupertinoPageRoute(
                builder: (_) => const HomeScreen(),
                settings: settings,
              );
          }
        },
      ),
      bottomNavigationBar: _bannerAd == null
          ? null
          : Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 75,
              child: AdWidget(ad: _bannerAd!),
            ),
    );
  }
}
