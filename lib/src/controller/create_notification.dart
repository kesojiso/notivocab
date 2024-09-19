import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notivocab/src/model/schema/schema_quiz_scope.dart';
import 'package:notivocab/src/model/schema/schema_notice_schedule.dart';
import 'package:notivocab/src/model/transact_notice_schedule_db.dart';
import 'package:notivocab/src/model/transact_quiz_scope_db.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:notivocab/src/model/transact_words_db.dart';

const notifyDays = 7; // 通知する日数

/* TDOO
  1. SharedPreferenceから通知時刻や出題範囲を取得する。
  2. 出題範囲の中からランダムに番号を選ぶ。
  3. DBから選ばれた番号に対応する単語を取得し、通知メッセージを作成する。
*/
// 通知を複数件スケジュールする
Future<void> setNotificationList() async {
  final scopeList = await getScopeList();
  final scheduleList = await getSchedule();
  final getWordNum = scheduleList.length * notifyDays; // 通知する単語数
  final wordsList = await getWordsList(scopeList, getWordNum);

  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

  await FlutterLocalNotificationsPlugin().cancelAll(); // 設定されている通知をキャンセル

  for (int i = 0; i < notifyDays; i++) {
    // notifyDays分の通知をスケジュールする
    tz.TZDateTime targetDate = now.add(Duration(days: i));

    for (int i = 0; i < scheduleList.length; i++) {
      tz.TZDateTime scheduledDate = tz.TZDateTime(
          tz.local,
          targetDate.year,
          targetDate.month,
          targetDate.day,
          scheduleList[i].hour!,
          scheduleList[i].minute!);

      // 過ぎた時間の場合は翌日
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // 通知をスケジュール（各通知にユニークなIDを付ける）
      await FlutterLocalNotificationsPlugin().zonedSchedule(
        i, // 各通知にユニークなIDを割り当て
        'notivocab', // 通知のタイトル
        wordsList[i],
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'multiple notification channel id',
            'Multiple Notifications',
            channelDescription:
                'This channel is used for multiple notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        // androidAllowWhileIdle: true, // 省電力モード中でも通知を表示
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
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

Future<List<String>> getWordsList(List<String> scopeList, int getNum) async {
  final TransactWordsDB transactDB = TransactWordsDB("ngsl_v1_2.db", "words");
  final List<String> wordsList =
      await transactDB.getRandomWords(scopeList, getNum);

  return wordsList;
}
