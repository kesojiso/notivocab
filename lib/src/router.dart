// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notivocab/src/view/word_detail_page.dart';
import 'package:notivocab/src/view/word_section_page.dart';
import 'package:notivocab/src/view/word_level_page.dart';
import 'package:notivocab/src/view/word_list_page.dart';
import 'view/homepage.dart';
import 'view/notice_setting/settingpage_top.dart';
import 'view/notice_setting/word_section/settingpage_word_section.dart';
import 'view/notice_setting/notice_schedule/notice_schedule.dart';

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
      routes: [
        // 通知時刻設定ページルート
        GoRoute(
          path: 'setting_notice_schedule',
          builder: (BuildContext context, GoRouterState state) {
            return const NoticeScheduleSettingPage();
          },
        ),
        // 出題範囲ページルート
        GoRoute(
          path: 'setting_word_section',
          builder: (BuildContext context, GoRouterState state) {
            return const WordSectionSettingPage();
          },
        ),
      ],
    ),
    // コース別単語帳ページルート
    GoRoute(
      path: '/word_level_page',
      builder: (BuildContext context, GoRouterState state) {
        return const WordLevelPage();
      },
      routes: [
        // セクション別ページルート
        GoRoute(
          path: 'word_section_page',
          builder: (BuildContext context, GoRouterState state) {
            final level = state.extra! as String;
            return WordSectionPage(level: level);
          },
        ),
      ],
    ),

    // 単語一覧ページルート
    GoRoute(
      path: '/words_list_page',
      builder: (BuildContext context, GoRouterState state) {
        final section = state.extra! as int;
        return WordListPage(section: section);
      },
    ),

    // My単語帳ページルート
    GoRoute(
      path: '/words_original',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
    // 単語詳細ページルート
    GoRoute(
      path: '/word_detail_page',
      builder: (BuildContext context, GoRouterState state) {
        final index = state.extra! as int;
        return WordDetailPage(
          index: index,
        );
      },
    ),
  ],
);
