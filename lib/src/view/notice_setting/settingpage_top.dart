import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants.dart';
import '../../component/button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Title(
          color: primaryColor,
          child: const Text('通知設定'),
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
                    defaultButton("通知スケジュール", () {
                      context.push('/setting_notice_schedule');
                    }),
                    defaultButton("出題範囲", () {
                      context.push('/setting_word_section');
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
