import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/constants.dart';
import '../../../model/setting_notice_schedule_input_form.dart';

final List<String> hours =
    List.generate(24, (index) => index.toString().padLeft(2, '0'));
final List<String> minutes =
    List.generate(6, (index) => (index * 10).toString().padLeft(2, '0'));

class ScheduleInputForm extends ConsumerWidget {
  const ScheduleInputForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hour = ref.watch(noticeHourMinuteProvider).hour;
    final minute = ref.watch(noticeHourMinuteProvider).minute;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScheduleDropDownMenu(
          items: hours,
          value: hour,
          onChanged: (String? value) {
            ref
                .read(noticeHourMinuteProvider.notifier)
                .updateSchedule(value, minute);
          },
        ),
        const SizedBox(width: 10),
        const Text(':', style: buttonTextStyle),
        const SizedBox(width: 10),
        ScheduleDropDownMenu(
          items: minutes,
          value: minute,
          onChanged: (String? value) {
            ref
                .read(noticeHourMinuteProvider.notifier)
                .updateSchedule(hour, value);
          },
        ),
      ],
    );
  }
}

class ScheduleDropDownMenu extends DropdownButton<String> {
  ScheduleDropDownMenu(
      {super.key,
      required List<String> items,
      required String value,
      required Function(String?) onChanged})
      : super(
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: buttonTextStyle),
            );
          }).toList(),
          value: value,
          onChanged: onChanged,
        );
}
