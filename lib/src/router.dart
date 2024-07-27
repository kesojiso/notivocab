// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'view/homepage.dart';
import 'view/settingpage_top.dart';
import 'view/settingpage_word_section.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    // デフォルトのホームページルート
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
    ),
    // 通知設定ページルート
    GoRoute(
      path: '/setting_notice',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    // 通知時刻設定ページルート
    GoRoute(
      path: '/setting_notice_time',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    // 出題範囲ページルート
    GoRoute(
      path: '/setting_word_section',
      builder: (BuildContext context, GoRouterState state) {
        return const WordSectionSettingPage();
      },
    ),
    // 初級ページルート
    GoRoute(
      path: '/words_level_entry',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    // 中級ページルート
    GoRoute(
      path: '/words_level_middle',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    // 上級ページルート
    GoRoute(
      path: '/words_level_high',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    // My単語帳ページルート
    GoRoute(
      path: '/words_original',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
  ],
);
