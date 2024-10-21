import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notivocab/src/schema/schema_notice_schedule.dart';

class TransactNoticeScheduleDB {
  // 唯一のインスタンスを保持する静的な変数
  static final TransactNoticeScheduleDB _instance =
      TransactNoticeScheduleDB._internal();

  // データベースのインスタンス
  Database? db;

  // プライベートなコンストラクタ
  TransactNoticeScheduleDB._internal();

  // ファクトリコンストラクタ
  factory TransactNoticeScheduleDB() {
    return _instance;
  }

  Future<void> openDB() async {
    try {
      final String dbPath = await getDatabasesPath();
      final String targetDBPath = join(dbPath, "setting.db");

      // データベースを開く
      db = await openDatabase(
        targetDBPath,
        version: 1,
      );

      // テーブルが存在するかを確認
      bool tableExists = await doesTableExist(db!, "setting_notice_schedule");

      if (!tableExists) {
        // テーブルが存在しない場合のみ作成
        await db!.execute(
          "CREATE TABLE setting_notice_schedule ("
          //"id INTEGER PRIMARY KEY,"
          "hour INTEGER NOT NULL,"
          "minute INTEGER NOT NULL"
          ")",
        );

        // 初期データを挿入
        await db!.insert("setting_notice_schedule", {
          "hour": 12,
          "minute": 0,
        });
      }
    } catch (e) {
      debugPrint("READ_DB_ERROR: $e");
    }
  }

  Future<bool> doesTableExist(Database db, String tableName) async {
    var res = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return res.isNotEmpty;
  }

  Future<void> updateDB(List<NoticeSchedule> noticeScheduleList) async {
    if (db == null) {
      await openDB();
    }

    await db!.transaction((txn) async {
      await txn.delete("setting_notice_schedule"); // 全レコードを削除

      for (NoticeSchedule noticeSchedule in noticeScheduleList) {
        await txn.insert(
          "setting_notice_schedule",
          {
            "hour": noticeSchedule.hour,
            "minute": noticeSchedule.minute,
          },
        );
      }
    });
  }

  Future<List<NoticeSchedule>> getValues() async {
    if (db == null) {
      await openDB();
    }
    final List<Map<String, dynamic>> maps =
        await db!.query("setting_notice_schedule");
    return maps
        .map((e) => NoticeSchedule(
              hour: e["hour"],
              minute: e["minute"],
            ))
        .toList();
  }
}
