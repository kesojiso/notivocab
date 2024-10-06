import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/controller/create_notification.dart';
import 'package:notivocab/src/controller/provider/setting_notice_schedule_input_form.dart';
import '../../../constants.dart';
import '../../../controller/provider/setting_notice_schedule.dart';
import '../../component/warningbox.dart';
import 'notice_timer_edit_form.dart';

class NoticeScheduleSettingPage extends ConsumerWidget {
  const NoticeScheduleSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeScheduleList =
        ref.watch(noticeScheduleProvider).noticeScheduleList;
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
                                      '${noticeScheduleList[index].hour.toString().padLeft(2, '0')} : ${noticeScheduleList[index].minute.toString().padLeft(2, '0')}',
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
                                ref
                                    .read(noticeScheduleInputFormProvider
                                        .notifier)
                                    .updateSchedule(
                                        noticeScheduleList[index]
                                            .hour
                                            .toString()
                                            .padLeft(2, '0'),
                                        noticeScheduleList[index]
                                            .minute
                                            .toString()
                                            .padLeft(2, '0'));
                                showCustomModalBottomSheet(
                                    context, ref, noticeScheduleList[index]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: buttonColor,
                  ),
                  child: const Icon(Icons.add, color: primaryColor, size: 90),
                  onPressed: () {
                    showCustomModalBottomSheet(context, ref, null);
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: buttonColor,
            onPressed: () {
              ref.read(noticeScheduleProvider.notifier).setNoticeSchedule();
              ref.invalidate(noticeScheduleProvider);
              setNotificationList();
              context.pop();
            },
            child: const Icon(Icons.save, color: primaryColor, size: 40)),
      ),
    );
  }
}
