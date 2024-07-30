import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import '../model/setting_notice_schedule.dart';

class NoticeScheduleSettingPage extends ConsumerWidget {
  const NoticeScheduleSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeScheduleList = ref.watch(noticeScheduleProvider).noticeSchedule;
    if (noticeScheduleList.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return PopScope(
        onPopInvoked: (bool result) {
          ref.invalidate(noticeScheduleProvider);
        },
        child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            title: const Text('通知スケジュール'),
          ),
          body: SafeArea(
            child: Center(
              child: SizedBox(
                height: 500,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  itemCount: noticeScheduleList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: buttonColor,
                      child: ListTile(
                        title: SizedBox(
                          height: 80,
                          child: Center(
                            child: Text(
                              noticeScheduleList[index],
                              style: buttonTextStyle,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: buttonColor,
              onPressed: () {
                ref.read(noticeScheduleProvider.notifier).setNoticeSchedule();
                ref.invalidate(noticeScheduleProvider);
                context.pop();
              },
              child: const Icon(Icons.add, color: primaryColor, size: 40)),
        ),
      );
    }
  }
}
