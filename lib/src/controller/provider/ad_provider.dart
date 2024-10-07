import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notivocab/ad_helper.dart';

final bannerAdProvider = StateProvider<BannerAd?>((ref) {
  BannerAd? bannerAd;

  bannerAd = BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    request: const AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) {
        bannerAd = ad as BannerAd;
      },
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Failed to load a banner ad: $error');
      },
    ),
  )..load();

  return bannerAd;
});
