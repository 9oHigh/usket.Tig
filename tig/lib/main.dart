import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tig/features/tig/presentation/widgets/tig_arrange_screen.dart';
import 'package:tig/features/tig/presentation/screens/tig_screen.dart';
import 'package:tig/core/utils/remove_scroll_animation.dart';
import 'package:tig/features/ads/data/datasource/admob_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:tig/core/routes/app_route.dart';
import 'package:tig/core/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: _TigScreenNavigator(
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
}

class _TigScreenNavigator extends StatelessWidget {
  const _TigScreenNavigator({
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
                builder: (_) => const TigArrangeScreen(),
                settings: settings,
              );
            case AppRoute.home:
            default:
              return CupertinoPageRoute(
                builder: (_) => const TigScreen(),
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
