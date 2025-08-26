import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
  static InterstitialAd? _interstitialAd;
  static bool _adLoaded = false;

  static String? get _interstitialAdUnitId {
    final id = Platform.isAndroid
        ? dotenv.env['ADMOB_ANDROID_INTERSTITIAL_ID']
        : Platform.isIOS
            ? dotenv.env['ADMOB_IOS_INTERSTITIAL_ID']
            : null;
    return id;
  }

  static String? get bannerAdUnitId {
    final id = Platform.isAndroid
        ? dotenv.env['ADMOB_ANDROID_BANNER_ID']
        : Platform.isIOS
            ? dotenv.env['ADMOB_IOS_BANNER_ID']
            : null;
    return id;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (Ad ad) {},
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
    },
    onAdOpened: (Ad ad) {},
    onAdClosed: (Ad ad) {},
  );

  static void loadInterstitialAd(VoidCallback onAdClosed, VoidCallback loaded) {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId!,
      request: const AdRequest(
        nonPersonalizedAds: true,
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _adLoaded = true;
          _showInterstitialAd(onAdClosed, loaded);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
          _adLoaded = false;
          do {
            Future.delayed(const Duration(seconds: 4), () {
              loadInterstitialAd(onAdClosed, loaded);
            });
          } while (_adLoaded);
        },
      ),
    );
  }

  static void _showInterstitialAd(
      VoidCallback onAdClosed, VoidCallback loaded) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        loaded();
        onAdClosed();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        loaded();
        onAdClosed();
      },
    );
    _interstitialAd!.show();
  }
}
