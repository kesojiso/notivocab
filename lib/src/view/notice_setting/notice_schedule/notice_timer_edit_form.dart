import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants.dart';
import 'schedle_dropdown_menu.dart';
import '../../../controller/provider/setting_notice_schedule.dart';
import '../../../controller/provider/setting_notice_schedule_input_form.dart';

void showCustomModalBottomSheet(
    BuildContext context, WidgetRef ref, int? targetIndex) {
  showModalBottomSheet(
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
                  bool isSuccess;
                  if (targetIndex == null) {
                    // Append schedule
                    isSuccess = ref
                        .read(noticeScheduleProvider.notifier)
                        .appendSchedule((
                      ref.watch(noticeScheduleInputFormProvider).hour,
                      ref.watch(noticeScheduleInputFormProvider).minute,
                    ));
                  } else {
                    // Edit schedule
                    isSuccess =
                        ref.read(noticeScheduleProvider.notifier).editSchedule((
                      ref.watch(noticeScheduleInputFormProvider).hour,
                      ref.watch(noticeScheduleInputFormProvider).minute,
                    ), targetIndex);
                  }

                  if (!isSuccess) {
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
}

const scheduleAlreadyExistSnackBar = SnackBar(
  backgroundColor: Colors.red,
  behavior: SnackBarBehavior.floating,
  margin: EdgeInsets.only(bottom: 200, left: 20, right: 20),
  content: Text("既に存在する時刻です"),
);
