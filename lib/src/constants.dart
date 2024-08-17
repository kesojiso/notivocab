import 'package:flutter/material.dart';

// Apps information
const String appName = '通知で覚える英単語';
const String appVersion = '0.0.1';

// Constants for colors
const Color primaryColor = Color(0xFF001F3D);
const Color secondaryColor = Color(0xFFD5A765);
const Color buttonColor = Color(0xFFF8DCBF);
const Color nonActiveColor = Color(0xFF575653);
const Color primaryTextColor = Color(0xFF000000);

// Constants for text styles
const TextStyle textStyleXL = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  color: primaryTextColor,
);

const TextStyle textStyleLL = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: primaryTextColor,
);

const TextStyle textStyleL = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: primaryTextColor,
);

const TextStyle textStylePronounce = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: primaryTextColor,
  fontFamilyFallback: ['NotoSans', 'Roboto'],
);

const TextStyle headerTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: secondaryColor,
);
const TextStyle buttonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: primaryTextColor,
);
const TextStyle normalTextStyle = TextStyle(
  fontSize: 16.0,
  color: primaryTextColor,
);
const TextStyle timerTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: primaryTextColor,
);
// Constants for API endpoints
const String baseUrl = 'https://api.example.com';
const String loginEndpoint = '/login';
const String userEndpoint = '/user';

// Constants for app settings
const int maxRetryAttempts = 3;
const double defaultFontSize = 16.0;

const List<String> examScope = [
  '初級',
  '中級',
  '上級',
  'My単語帳',
];

const List<(String, String)> defaultNoticeSchedule = [
  ('12', '00'),
];

const noticeDoesNotSetWarningTitle = '※通知の時刻がセットされていません！';
const noticeDoesNotSetWarningSubtitle = '通知時刻を追加して学習を始めましょう';

// const dbSchema =
//     "rank INTEGER PRIMARY KEY, rank_seg INTEGER, word TEXT, word_japanese TEXT, pos_full TEXT, pronounce TEXT";

const List<String> assetDBList = [
  "ngsl_v1_2.db",
];
