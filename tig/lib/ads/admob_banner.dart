import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobBanner extends StatelessWidget {
  final BannerAd? bannerAd;

  const AdmobBanner({super.key, this.bannerAd});

  @override
  Widget build(BuildContext context) {
    if (bannerAd == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }
}
