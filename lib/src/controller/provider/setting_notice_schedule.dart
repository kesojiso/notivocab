import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/constants.dart';
import '../access_shared_preference.dart';

// TODO: sharedPreferenceではなくDBで管理する

final noticeScheduleProvider =
    StateNotifierProvider<NoticeScheduleNotifier, NoticeScheduleState>((ref) {
  return NoticeScheduleNotifier();
});

class NoticeScheduleState {
  List<(String, String)> noticeSchedule;
  NoticeScheduleState({this.noticeSchedule = const []});

  NoticeScheduleState copyWith({List<(String, String)>? noticeSchedule}) {
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
    final List<String>? noticeScheduleStr =
        await _sharedPreferencesService.getValue('noticeSchedule');
    if (noticeScheduleStr == null) {
      state = NoticeScheduleState(noticeSchedule: defaultNoticeSchedule);
      return;
    }
    final List<(String, String)> noticeSchedule = noticeScheduleStr
        .map((e) => (e.split(':')[0], e.split(':')[1]))
        .toList();
    state = NoticeScheduleState(noticeSchedule: noticeSchedule);
  }

  bool appendSchedule((String, String) appendedTime) {
    List<(String, String)> noticeSchedule = List.from(state.noticeSchedule);
    if (!_validateAppendSchedule(appendedTime)) {
      return false;
    }
    noticeSchedule.add(appendedTime);
    noticeSchedule.sort((a, b) {
      int result = a.$1.compareTo(b.$1);
      if (result != 0) return result;
      return a.$2.compareTo(b.$2);
    });
    state = state.copyWith(noticeSchedule: noticeSchedule);
    return true;
  }

  bool _validateAppendSchedule((String, String) appendedTime) {
    List<(String, String)> noticeSchedule = state.noticeSchedule;
    if (noticeSchedule.contains(appendedTime)) {
      return false;
    }
    return true;
  }

  void remoevSchedule((String, String) removedTime) {
    List<(String, String)> noticeSchedule = List.from(state.noticeSchedule);
    noticeSchedule.remove(removedTime);
    noticeSchedule.sort((a, b) {
      int result = a.$1.compareTo(b.$1);
      if (result != 0) return result;
      return a.$2.compareTo(b.$2);
    });
    state = state.copyWith(noticeSchedule: noticeSchedule);
  }

  Future<void> setNoticeSchedule() async {
    final List<(String, String)> noticeSchedule = state.noticeSchedule;
    final List<String> noticeScheduleStr =
        noticeSchedule.map((e) => '${e.$1}:${e.$2}').toList();
    await _sharedPreferencesService.setValue(
        'noticeSchedule', noticeScheduleStr);
  }
}
