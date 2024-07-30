import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/constants.dart';
import 'access_shared_preference.dart';

final noticeScheduleProvider =
    StateNotifierProvider<NoticeScheduleNotifier, NoticeScheduleState>((ref) {
  return NoticeScheduleNotifier();
});

class NoticeScheduleState {
  List<String> noticeSchedule;
  NoticeScheduleState({this.noticeSchedule = const []});

  NoticeScheduleState copyWith({List<String>? noticeSchedule}) {
    return NoticeScheduleState(
      noticeSchedule: noticeSchedule ?? this.noticeSchedule,
    );
  }
}

class NoticeScheduleNotifier extends StateNotifier<NoticeScheduleState> {
  final SharedPreferencesService _sharedPreferencesService =
      SharedPreferencesService();

  NoticeScheduleNotifier() : super(NoticeScheduleState()) {
    _loadInitialNoticeSchedule();
  }

  Future<void> _loadInitialNoticeSchedule() async {
    final List<String>? noticeSchedule =
        await _sharedPreferencesService.getValue('noticeSchedule');
    if (noticeSchedule == null) {
      state = NoticeScheduleState(noticeSchedule: defaultNoticeSchedule);
      return;
    }
    state = NoticeScheduleState(noticeSchedule: noticeSchedule);
  }

  void appendSchedule(String appendedTime) {
    List<String> noticeSchedule = state.noticeSchedule;
    noticeSchedule.add(appendedTime);
    noticeSchedule.sort((a, b) => a.compareTo(b));
    state = state.copyWith(noticeSchedule: noticeSchedule);
  }

  void remoevSchedule(String removedTime) {
    List<String> noticeSchedule = state.noticeSchedule;
    noticeSchedule.remove(removedTime);
    noticeSchedule.sort((a, b) => a.compareTo(b));
  }

  Future<void> setNoticeSchedule() async {
    final List<String> noticeSchedule = state.noticeSchedule;
    await _sharedPreferencesService.setValue('noticeSchedule', noticeSchedule);
  }
}
