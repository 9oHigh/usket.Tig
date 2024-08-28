import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdMobService {
  //배너광고
  //앱 개발시 테스트광고 ID로 입력
  static String? get bannerAdUnitId {
    String? id;
    if (Platform.isAndroid) {
      id = dotenv.env['ADMOB_ANDROID_BANNER_ID'];
    } else if (Platform.isIOS) {
      id = dotenv.env['ADMOB_IOS_BANNER_ID'];
    }
    return id;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print('Ad fail to load: $error');
    },
    onAdOpened: (ad) => print('Ad opened'),
    onAdClosed: (ad) => print('Ad closed'),
  );
}
