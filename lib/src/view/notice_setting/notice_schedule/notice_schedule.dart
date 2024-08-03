import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants.dart';
import '../../../model/setting_notice_schedule.dart';
import 'schedle_dropdown_menu.dart';
import '../../../model/setting_notice_schedule_input_form.dart';
import '../../../component/warningbox.dart';

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
                              onTap: () {},
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

class NoticeTimeAppendForm extends ConsumerWidget {
  const NoticeTimeAppendForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: buttonColor,
        ),
        child: const Icon(Icons.add, color: primaryColor, size: 90),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: buttonColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('通知時刻を入力してください', style: normalTextStyle),
                      const ScheduleInputForm(),
                      ElevatedButton(
                        child: const Text('追加'),
                        onPressed: () {
                          bool ans = ref
                              .read(noticeScheduleProvider.notifier)
                              .appendSchedule((
                            ref.watch(noticeHourMinuteProvider).hour,
                            ref.watch(noticeHourMinuteProvider).minute
                          ));
                          if (!ans) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(scheduleAlreadyExistSnackBar);
                            return;
                          }
                          Navigator.pop(context);
                          ref.invalidate(noticeHourMinuteProvider);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

const scheduleAlreadyExistSnackBar = SnackBar(
  backgroundColor: Colors.red,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.only(bottom: 200, left: 20, right: 20),
  content: Text("既に存在する時刻です"),
);
