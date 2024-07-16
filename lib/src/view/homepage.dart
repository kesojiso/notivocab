import 'package:flutter/material.dart';
import '../constants.dart';
import '../component/button.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title, required this.version});
  final String title;
  final String version;

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
                    defaultButton("コース別単語帳", () {}),
                    defaultButton("My単語帳", () {}),
                    defaultButton("通知設定", () {})
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
