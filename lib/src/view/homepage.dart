import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notivocab/src/controller/provider/ad_provider.dart';
import '../constants.dart';
import 'component/button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAd = ref.watch(bannerAdProvider);
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset("asset/notivocab-icon.png", fit: BoxFit.fitWidth),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultButton("コース別単語帳", () {
                      context.push('/word_level_page');
                    }),
                    defaultButton("My単語帳", () {}),
                    defaultButton("通知設定", () {
                      context.push('/setting_notice');
                    })
                  ],
                ),
              ),
              if (bannerAd != null)
                SizedBox(
                  width: bannerAd.size.width.toDouble(),
                  height: bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
