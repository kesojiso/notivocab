import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:notivocab/src/controller/access_shared_preference.dart';
import 'package:notivocab/src/model/transact_words_db.dart';
import 'package:notivocab/src/constants.dart';

const notifyNum = 100;

/* TDOO
  1. SharedPreferenceから通知時刻や出題範囲を取得する。
  2. 出題範囲の中からランダムに番号を選ぶ。
  3. DBから選ばれた番号に対応する単語を取得し、通知メッセージを作成する。
*/
// 通知を複数件スケジュールする
Future<void> setNotificationList() async {
  final dynamic sectionList =
      await SharedPreferencesService().getValue('examScope');
  final TransactWordsDB transactDB = TransactWordsDB("ngsl_v1_2.db", "words");
  final List<String> wordsList =
      await transactDB.getRandomWords(sectionList, getNum);
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

  await FlutterLocalNotificationsPlugin().cancelAll(); // 設定されている通知をキャンセル

  for (int i = 0; i < wordsList.length; i++) {
    // 毎日8時に通知を設定（例として、異なるメッセージを1時間後ずつ設定）
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 22)
            .add(Duration(minutes: i));

    // 過ぎた時間の場合は翌日
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // 通知をスケジュール（各通知にユニークなIDを付ける）
    await FlutterLocalNotificationsPlugin().zonedSchedule(
      i, // 各通知にユニークなIDを割り当て
      'notivocab', // 通知のタイトル
      '${wordsList[i]}',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'multiple notification channel id',
          'Multiple Notifications',
          channelDescription: 'This channel is used for multiple notifications',
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
