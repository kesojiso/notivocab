import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notivocab/src/feature/words/repository/transact_words_db.dart';
import '../../../core/constants.dart';
import '../../common/view/component/card.dart';
import 'package:notivocab/src/feature/ads/view/banner_ad.dart';

class WordSectionPage extends StatelessWidget {
  final String level;
  const WordSectionPage({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    TransactWordsDB transactDB = TransactWordsDB("ngsl_v1_2.db", "words");
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Title(
          color: primaryColor,
          child: Text(level),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<int>>(
            future: transactDB.returnSectionCount(level),
            builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return defaultCard("Section ${snapshot.data![index]}", () {
                      context.push(
                          '/word_level_page/word_section_page/words_list_page',
                          extra: snapshot.data![index]);
                    });
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: const AdBannerWidget(),
    );
  }
}
