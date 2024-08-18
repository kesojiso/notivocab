import 'package:flutter_riverpod/flutter_riverpod.dart';

final noticeHourMinuteProvider = StateNotifierProvider<
    NoticeScheduleInputFormNotifier, NoticeScheduleInputFormState>((ref) {
  return NoticeScheduleInputFormNotifier();
});

class NoticeScheduleInputFormState {
  String hour;
  String minute;
  NoticeScheduleInputFormState({this.hour = '12', this.minute = '00'});
  NoticeScheduleInputFormState copyWith({String? hour, String? minute}) {
    return NoticeScheduleInputFormState(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }
}

class NoticeScheduleInputFormNotifier
    extends StateNotifier<NoticeScheduleInputFormState> {
  NoticeScheduleInputFormNotifier() : super(NoticeScheduleInputFormState());

  void updateSchedule(String? hour, String? minute) {
    state = state.copyWith(hour: hour, minute: minute);
  }
}
