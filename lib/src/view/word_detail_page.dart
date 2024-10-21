import 'package:flutter/material.dart';
import 'package:notivocab/src/core/constants.dart';
import 'package:notivocab/src/feature/common/repository/transact_words_db.dart';
import 'package:notivocab/src/view/component/card.dart';
import 'package:notivocab/src/feature/ads/view/banner_ad.dart';

class WordDetailPage extends StatelessWidget {
  final int index;
  const WordDetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    TransactWordsDB transactDB = TransactWordsDB("ngsl_v1_2.db", "words");
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
            child: FutureBuilder<Map<String, dynamic>>(
          future: transactDB.getWordInfo(index),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 300,
                child: singleWordCard(
                    index,
                    snapshot.data!['word']!,
                    snapshot.data!['word_japanese']!,
                    snapshot.data!['pos_full']!,
                    snapshot.data!['pronounce']!),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        )),
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }
}
