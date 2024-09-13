import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
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
}
