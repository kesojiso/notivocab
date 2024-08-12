import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants.dart';
import '../component/button.dart';

class WordLevelPage extends StatelessWidget {
  const WordLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Title(
          color: primaryColor,
          child: const Text('コース別単語帳'),
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
                      context.push('/words_by_course/words_level_entry');
                    }),
                    defaultButton("中級", () {
                      // context.push('/words_by_course/words_level_middle');
                    }),
                    defaultButton("上級", () {
                      // context.push('/words_by_course/words_level_advanced');
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
