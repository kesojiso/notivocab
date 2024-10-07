import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/model/schema/schema_notice_schedule.dart';
import 'package:notivocab/src/model/transact_notice_schedule_db.dart';

final noticeScheduleProvider =
    StateNotifierProvider<NoticeScheduleNotifier, NoticeScheduleState>((ref) {
  return NoticeScheduleNotifier();
});

class NoticeScheduleState {
  List<NoticeSchedule> noticeScheduleList;
  NoticeScheduleState({this.noticeScheduleList = const []});

  NoticeScheduleState copyWith({List<NoticeSchedule>? noticeScheduleList}) {
    return NoticeScheduleState(
      noticeScheduleList: noticeScheduleList ?? this.noticeScheduleList,
    );
  }
}

class NoticeScheduleNotifier extends StateNotifier<NoticeScheduleState> {
  final TransactNoticeScheduleDB _transactNoticeScheduleDB =
      TransactNoticeScheduleDB();

  NoticeScheduleNotifier() : super(NoticeScheduleState()) {
    _loadInitialNoticeSchedule();
  }

  Future<void> _loadInitialNoticeSchedule() async {
    final List<NoticeSchedule> noticeScheduleList =
        await _transactNoticeScheduleDB.getValues();

    state = NoticeScheduleState(noticeScheduleList: noticeScheduleList);
  }

  bool editSchedule((String, String) modifiedTimeStr, int editIndex) {
    List<NoticeSchedule> noticeScheduleList =
        List.from(state.noticeScheduleList);
    NoticeSchedule modifiedTime = NoticeSchedule(
      hour: int.parse(modifiedTimeStr.$1),
      minute: int.parse(modifiedTimeStr.$2),
    );
    if (!_validateAppendSchedule(modifiedTime)) {
      return false;
    }
    noticeScheduleList[editIndex] = modifiedTime;
    noticeScheduleList.sort((a, b) {
      int result = a.hour!.compareTo(b.hour!);
      if (result != 0) return result;
      return a.minute!.compareTo(b.minute!);
    });
    state = state.copyWith(noticeScheduleList: noticeScheduleList);
    return true;
  }

  bool appendSchedule((String, String) appendedTimeStr) {
    List<NoticeSchedule> noticeScheduleList =
        List.from(state.noticeScheduleList);
    NoticeSchedule appendedTime = NoticeSchedule(
      hour: int.parse(appendedTimeStr.$1),
      minute: int.parse(appendedTimeStr.$2),
    );
    if (!_validateAppendSchedule(appendedTime)) {
      return false;
    }
    noticeScheduleList.add(appendedTime);
    noticeScheduleList.sort((a, b) {
      int result = a.hour!.compareTo(b.hour!);
      if (result != 0) return result;
      return a.minute!.compareTo(b.minute!);
    });
    state = state.copyWith(noticeScheduleList: noticeScheduleList);
    return true;
  }

  bool _validateAppendSchedule(NoticeSchedule appendedTime) {
    List<NoticeSchedule> noticeScheduleList = state.noticeScheduleList;
    if (noticeScheduleList.contains(appendedTime)) {
      return false;
    }
    return true;
  }

  List<NoticeSchedule> sortSchedule(List<NoticeSchedule> noticeScheduleList) {
    noticeScheduleList.sort((a, b) {
      int result = a.hour!.compareTo(b.hour!);
      if (result != 0) return result;
      return a.minute!.compareTo(b.minute!);
    });
    return noticeScheduleList;
  }

  void remoevSchedule(int removeIndex) {
    List<NoticeSchedule> noticeScheduleList =
        List.from(state.noticeScheduleList);
    noticeScheduleList.removeAt(removeIndex);
    noticeScheduleList.sort((a, b) {
      int result = a.hour!.compareTo(b.hour!);
      if (result != 0) return result;
      return a.minute!.compareTo(b.minute!);
    });
    state = state.copyWith(noticeScheduleList: noticeScheduleList);
  }

  Future<void> setNoticeSchedule() async {
    final List<NoticeSchedule> noticeScheduleList = state.noticeScheduleList;
    await _transactNoticeScheduleDB.updateDB(noticeScheduleList);
  }
}
