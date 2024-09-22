import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/constants.dart';
import 'package:notivocab/src/controller/copy_db_from_asset.dart';
import 'src/router.dart';

@pragma('vm:entry-point') // このデコレーターで、バックグラウンドから呼び出されることを示す
void notificationTapBackground(NotificationResponse notificationResponse) {
  // バックグラウンドでの処理
  String? payload = notificationResponse.payload;
  if (payload != null && payload.isNotEmpty) {
    navigatorKey.currentContext?.go(payload); // GoRouterを使った画面遷移など
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // タイムゾーンの初期化
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // 通知の許可をリクエスト
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  // アラームの許可をリクエスト
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestExactAlarmsPermission();
  // 通知の初期化
  await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ), onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
    String? payload = notificationResponse.payload;
    if (payload != null && payload.isNotEmpty) {
      navigatorKey.currentContext?.go(payload);
    }
  }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    for (final dbName in assetDBList) {
      copyDBFromAsset(dbName);
    }
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "NotoSansJP",
      ),
    );
  }
}
