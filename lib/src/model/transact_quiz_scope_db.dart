import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notivocab/src/schema/schema_quiz_scope.dart';

class TransactQuizScopeDB {
  // 唯一のインスタンスを保持する静的な変数
  static final TransactQuizScopeDB _instance = TransactQuizScopeDB._internal();

  // データベースのインスタンス
  Database? db;

  // プライベートなコンストラクタ
  TransactQuizScopeDB._internal();

  // ファクトリコンストラクタ
  factory TransactQuizScopeDB() {
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
      bool tableExists = await doesTableExist(db!, "setting_quiz_scope");

      if (!tableExists) {
        // テーブルが存在しない場合のみ作成
        await db!.execute(
          "CREATE TABLE setting_quiz_scope ("
          "id INTEGER PRIMARY KEY,"
          "entry INTEGER NOT NULL,"
          "intermediate INTEGER NOT NULL,"
          "advanced INTEGER NOT NULL,"
          "my_word_list INTEGER NOT NULL"
          ")",
        );

        // 初期データを挿入
        await db!.insert("setting_quiz_scope", {
          "id": 999,
          "entry": 1,
          "intermediate": 1,
          "advanced": 1,
          "my_word_list": 0,
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

  Future<void> updateDB(QuizScope quizScope) async {
    if (db == null) {
      await openDB();
    }
    await db!.update(
      "setting_quiz_scope",
      {
        "entry": quizScope.entry,
        "intermediate": quizScope.intermediate,
        "advanced": quizScope.advanced,
        "my_word_list": quizScope.myWordList
      },
      where: "id = ?",
      whereArgs: [999],
    );
  }

  Future<QuizScope> getValues() async {
    if (db == null) {
      await openDB();
    }
    final List<Map<String, dynamic>> maps =
        await db!.query("setting_quiz_scope");
    return QuizScope(
      entry: maps[0]["entry"] > 0,
      intermediate: maps[0]["intermediate"] > 0,
      advanced: maps[0]["advanced"] > 0,
      myWordList: maps[0]["my_word_list"] > 0,
    );
  }
}
