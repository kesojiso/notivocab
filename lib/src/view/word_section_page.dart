import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notivocab/src/model/transact_db.dart';
import '../constants.dart';
import '../component/card.dart';

class WordSectionPage extends StatelessWidget {
  const WordSectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactDB transactDB = TransactDB("ngsl_v1_2.db", "words");
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Title(
          color: primaryColor,
          child: const Text('初級'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<int>(
            future: transactDB.returnSectionCount(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data,
                  itemBuilder: (BuildContext context, int index) {
                    return defaultCard("Section ${index + 1}", () {
                      context.push('/words_list_page', extra: index + 1);
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
