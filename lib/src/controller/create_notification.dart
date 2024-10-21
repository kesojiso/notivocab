import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notivocab/src/schema/schema_quiz_scope.dart';
import 'package:notivocab/src/schema/schema_notice_schedule.dart';
import 'package:notivocab/src/model/transact_notice_schedule_db.dart';
import 'package:notivocab/src/model/transact_quiz_scope_db.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:notivocab/src/model/transact_words_db.dart';

const notifyDays = 7; // 通知する日数

// 通知を複数件スケジュールする
Future<void> setNotificationList() async {
  final scopeList = await getScopeList();
  final scheduleList = await getSchedule();
  final getWordNum = scheduleList.length * notifyDays; // 通知する単語数
  final wordsMap = await getWordsList(scopeList, getWordNum);
  var notifyIndex = 0;

  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

  await FlutterLocalNotificationsPlugin().cancelAll(); // 設定されている通知をキャンセル

  for (int dateDiff = 0; dateDiff < notifyDays; dateDiff++) {
    // notifyDays分の通知をスケジュールする
    tz.TZDateTime targetDate = now.add(Duration(days: dateDiff));

    for (int scheduleIdx = 0;
        scheduleIdx < scheduleList.length;
        scheduleIdx++) {
      tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local,
          targetDate.year,
          targetDate.month,
          targetDate.day,
          scheduleList[scheduleIdx].hour!,
          scheduleList[scheduleIdx].minute!);

      // 過ぎた時間の場合は翌日
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // 通知をスケジュール（各通知にユニークなIDを付ける）
      await FlutterLocalNotificationsPlugin().zonedSchedule(
        notifyIndex, // 各通知にユニークなIDを割り当て
        'この英単語の意味はわかるかな？', // 通知のタイトル
        wordsMap[notifyIndex]['word'], // 通知のメッセージ
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'multiple notification channel id',
            'Multiple Notifications',
            channelDescription:
                'This channel is used for multiple notifications',
            importance: Importance.max,
            priority: Priority.high,
            visibility: NotificationVisibility.public, // 通知の可視性
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock, // 省電力モード中でも通知を表示
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        //matchDateTimeComponents: DateTimeComponents.time,
        payload: '/word_detail_page/${wordsMap[notifyIndex]['rank']}',
      );
      notifyIndex++;
    }
  }
}

Future<List<String>> getScopeList() async {
  final transactQuizScope = TransactQuizScopeDB();
  final QuizScope quizScope = await transactQuizScope.getValues();
  final List<String> scopeList = [];
  if (quizScope.entry!) {
    scopeList.add('entry');
  }
  if (quizScope.intermediate!) {
    scopeList.add('intermediate');
  }
  if (quizScope.advanced!) {
    scopeList.add('advanced');
  }
  if (quizScope.myWordList!) {
    scopeList.add('myWordList');
  }
  return scopeList;
}

Future<List<NoticeSchedule>> getSchedule() async {
  final TransactNoticeScheduleDB scheduleDB = TransactNoticeScheduleDB();
  final List<NoticeSchedule> noticeScheduleList = await scheduleDB.getValues();
  return noticeScheduleList;
}

Future<List<Map<String, String>>> getWordsList(
    List<String> scopeList, int getNum) async {
  final TransactWordsDB transactDB = TransactWordsDB("ngsl_v1_2.db", "words");
  final List<Map<String, String>> wordsMap =
      await transactDB.getRandomWords(scopeList, getNum);

  return wordsMap;
}
