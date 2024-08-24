import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/controller/create_notification.dart';
import '../../../constants.dart';
import '../../../controller/provider/setting_notice_schedule.dart';
import '../../component/warningbox.dart';
import 'notice_timem_append_form.dart';

class NoticeScheduleSettingPage extends ConsumerWidget {
  const NoticeScheduleSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeScheduleList = ref.watch(noticeScheduleProvider).noticeSchedule;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              noticeScheduleList.isEmpty
                  ? const Warningbox(
                      titleText: noticeDoesNotSetWarningTitle,
                      subtitleText: noticeDoesNotSetWarningSubtitle,
                    )
                  : SizedBox(
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Text(
                                      '${noticeScheduleList[index].$1} : ${noticeScheduleList[index].$2}',
                                      style: timerTextStyle,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(noticeScheduleProvider
                                                  .notifier)
                                              .remoevSchedule(
                                                  noticeScheduleList[index]);
                                        },
                                        child: const Icon(Icons.delete,
                                            color: primaryColor, size: 30)),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setNotificationList();
                              },
                            ),
                          );
                        },
                      ),
                    ),
              const NoticeTimeAppendForm(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: buttonColor,
            onPressed: () {
              ref.read(noticeScheduleProvider.notifier).setNoticeSchedule();
              ref.invalidate(noticeScheduleProvider);
              context.pop();
            },
            child: const Icon(Icons.save, color: primaryColor, size: 40)),
      ),
    );
  }
}
