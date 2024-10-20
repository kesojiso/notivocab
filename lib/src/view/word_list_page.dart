import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notivocab/src/model/transact_words_db.dart';
import '../constants.dart';
import 'component/card.dart';
import 'package:notivocab/src/feature/ads/view/banner_ad.dart';

class WordListPage extends StatelessWidget {
  final int section;
  const WordListPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    TransactWordsDB transactDB = TransactWordsDB("ngsl_v1_2.db", "words");
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Title(
          color: primaryColor,
          child: Text('Section $section'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: transactDB.returnWords(section),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return wordsListCard(snapshot.data![index]['rank']!,
                        snapshot.data![index]['word']!, () {
                      context.push(
                        '/word_level_page/word_section_page/words_list_page/word_detail_page/${snapshot.data![index]['rank']}',
                      );
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
