import 'dart:io';
import 'dart:ui';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
  static String? get interstitialAdUnitId {
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

  static InterstitialAd? _interstitialAd;

  static void loadInterstitialAd(VoidCallback onAdClosed) {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          showInterstitialAd(onAdClosed);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  static void showInterstitialAd(VoidCallback onAdClosed) {
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
       onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        onAdClosed();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
      },
    );
    _interstitialAd!.show();
  }
}
