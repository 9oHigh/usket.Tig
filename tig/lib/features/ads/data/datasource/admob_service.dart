import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
  // 플랫폼에 따라 AdMob 광고 ID를 불러오는 메서드
  static String? get bannerAdUnitId {
    final id = Platform.isAndroid
        ? dotenv.env['ADMOB_ANDROID_BANNER_ID']
        : Platform.isIOS
            ? dotenv.env['ADMOB_IOS_BANNER_ID']
            : null;
    return id;
  }

  // 광고 이벤트 리스너 정의
  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (Ad ad) {},
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
    },
    onAdOpened: (Ad ad) {},
    onAdClosed: (Ad ad) {},
  );
}
