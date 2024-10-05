import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants.dart';
import 'schedle_dropdown_menu.dart';
import '../../../controller/provider/setting_notice_schedule.dart';
import '../../../controller/provider/setting_notice_schedule_input_form.dart';

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
                            ref.watch(noticeScheduleInputFormProvider).hour,
                            ref.watch(noticeScheduleInputFormProvider).minute
                          ));
                          if (!ans) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(scheduleAlreadyExistSnackBar);
                            return;
                          }
                          Navigator.pop(context);
                          ref.invalidate(noticeScheduleInputFormProvider);
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
