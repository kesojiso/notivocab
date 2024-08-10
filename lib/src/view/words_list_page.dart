import 'package:flutter/material.dart';
import 'package:notivocab/src/model/transact_db.dart';
import '../constants.dart';
import '../component/card.dart';

class WordsListPage extends StatelessWidget {
  final int section;
  const WordsListPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    TransactDB transactDB = TransactDB("ngsl_v1_2.db", "words");
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
          child: FutureBuilder<List<Map<String, String>>>(
            future: transactDB.returnWords(section),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, String>>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return wordCard(snapshot.data![index]['rank']!,
                        snapshot.data![index]['word']!, () {
                      //context.push('/words_by_course/words_level_entry/section/$index');
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
    );
  }
}
