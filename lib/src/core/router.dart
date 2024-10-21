// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notivocab/src/view/word_detail_page.dart';
import 'package:notivocab/src/view/word_section_page.dart';
import 'package:notivocab/src/view/word_level_page.dart';
import 'package:notivocab/src/view/word_list_page.dart';
import '../view/homepage.dart';
import '../view/notice_setting/settingpage_top.dart';
import '../feature/setting/view/quiz_scope.dart';
import '../feature/setting/view/notice_schedule.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    // デフォルトのホームページルート
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: [
        // 通知設定ページルート
        GoRoute(
          path: 'setting_notice',
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
              path: 'setting_quiz_scope',
              builder: (BuildContext context, GoRouterState state) {
                return const QuizScopeSettingPage();
              },
            ),
          ],
        ),
        // コース別単語帳ページルート
        GoRoute(
          path: 'word_level_page',
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
              routes: [
                // 単語一覧ページルート
                GoRoute(
                  path: 'words_list_page',
                  builder: (BuildContext context, GoRouterState state) {
                    final section = state.extra! as int;
                    return WordListPage(section: section);
                  },
                  routes: [
                    // 単語詳細ページルート
                    GoRoute(
                      path: 'word_detail_page/:index',
                      builder: (BuildContext context, GoRouterState state) {
                        // pathParameters['index'] を int に変換できない場合は 0 とする
                        final index = int.tryParse(
                                state.pathParameters['index'] ?? '0') ??
                            0;
                        return WordDetailPage(
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // My単語帳ページルート
        GoRoute(
          path: 'words_original',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingPage();
          },
        ),
        GoRoute(
          path: 'word_detail_page/:index',
          builder: (BuildContext context, GoRouterState state) {
            // pathParameters['index'] を int に変換できない場合は 0 とする
            final index =
                int.tryParse(state.pathParameters['index'] ?? '0') ?? 0;
            return WordDetailPage(
              index: index,
            );
          },
        ),
      ],
    ),
  ],
);
