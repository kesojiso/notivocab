import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants.dart';
import '../component/button.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
