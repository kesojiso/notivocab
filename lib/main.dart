import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:go_router/go_router.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/constants.dart';
import 'package:notivocab/src/controller/copy_db_from_asset.dart';
import 'src/core/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // タイムゾーンの初期化
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

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
    ),
    onDidReceiveNotificationResponse: notificationTapForeground,
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  // 広告の初期化
  MobileAds.instance.initialize();

  runApp(ProviderScope(child: MyApp(notificationAppLaunchDetails)));
}

class MyApp extends StatelessWidget {
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  const MyApp(this.notificationAppLaunchDetails, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    for (final dbName in assetDBList) {
      copyDBFromAsset(dbName);
    }
    // アプリが通知から起動された場合の処理
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      String? payload =
          notificationAppLaunchDetails?.notificationResponse?.payload;
      if (payload != null && payload.isNotEmpty) {
        // 適切な画面に遷移
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            navigatorKey.currentContext?.push(payload); // GoRouterでの画面遷移
          },
        );
      }
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

Future<void> notificationTapForeground(
    NotificationResponse notificationResponse) async {
  // フォアグラウンドでの処理
  String? payload = notificationResponse.payload;
  if (payload != null && payload.isNotEmpty) {
    navigatorKey.currentContext?.push(payload); // GoRouterを使った画面遷移など
  }
}

@pragma('vm:entry-point') // このデコレーターで、バックグラウンドから呼び出されることを示す
void notificationTapBackground(NotificationResponse notificationResponse) {
  //print("start app from notification");
}
