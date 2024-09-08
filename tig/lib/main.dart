import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tig/screens/home/home_arrange_screen.dart';
import 'package:tig/screens/home/home_screen.dart';
import 'package:tig/utils/remove_scroll_animation.dart';
import 'package:tig/services/admob_service.dart';
import 'package:flutter/cupertino.dart';

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
    _initGoogleMobileAds();
    _createBannerAd();
    super.initState();
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
      theme: ThemeData(
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
      ),
      darkTheme: ThemeData(
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
      ),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            Widget page = const HomeScreen();
            if (settings.name == '/arrange') {
              page = const HomeArrangeScreen();
            }

            return CupertinoPageRoute(
              builder: (_) => page,
              settings: settings,
            );
          },
        ),
        bottomNavigationBar: _bannerAd == null
            ? null
            : Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 75,
                child: AdWidget(ad: _bannerAd!),
              ),
      ),
    );
  }

  void switchScreen(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
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
