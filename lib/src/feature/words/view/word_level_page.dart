import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:notivocab/src/feature/ads/view/banner_ad.dart';
import '../../../core/constants.dart';
import '../../common/view/component/button.dart';

class WordLevelPage extends ConsumerWidget {
  const WordLevelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Title(
          color: primaryColor,
          child: const Text('レベル別単語帳'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultButton("初級", () {
                      context.push('/word_level_page/word_section_page',
                          extra: "entry");
                    }),
                    defaultButton("中級", () {
                      context.push('/word_level_page/word_section_page',
                          extra: "intermediate");
                    }),
                    defaultButton("上級", () {
                      context.push('/word_level_page/word_section_page',
                          extra: "advanced");
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }
}
