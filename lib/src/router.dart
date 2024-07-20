// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'view/homepage.dart';
import 'view/settingpage.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    // デフォルトのホームページルート
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
    ),
    // settingpage ルート
    GoRoute(
      path: '/settingpage',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingPage();
      },
    ),
  ],
);
