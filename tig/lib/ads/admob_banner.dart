import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobBanner extends StatelessWidget {
  final BannerAd? _bannerAd;

  const AdmobBanner({super.key, BannerAd? bannerAd}) : _bannerAd = bannerAd;

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: _bannerAd.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd),
    );
  }
}
