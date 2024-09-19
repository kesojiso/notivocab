import 'package:flutter/material.dart';
import 'package:notivocab/src/controller/copy_db_from_asset.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TransactWordsDB {
  final String dbName;
  final String tableName;
  Database? db;
  TransactWordsDB(this.dbName, this.tableName);

  Future<void> readDataBase() async {
    try {
      final String dbPath = await getDatabasesPath();
      final String targetDBPath = join(dbPath, dbName);
      final bool dbExistFlg = await databaseExists(targetDBPath);
      if (!dbExistFlg) {
        copyDBFromAsset(targetDBPath);
      }
      db = await openDatabase(
        targetDBPath,
        version: 1,
        readOnly: false,
      );
    } catch (e) {
      debugPrint("READ_DB_ERROR: $e");
    }
  }

  Future<List<int>> returnSectionCount(String level) async {
    await readDataBase();

    if (db != null) {
      final List<Map<String, dynamic>> maps = await db!.rawQuery(
          "SELECT DISTINCT rank_seg, level FROM $tableName WHERE level = '$level' ORDER BY rank_seg ASC");
      return List.generate(
        maps.length,
        (i) {
          return maps[i]['rank_seg'] as int;
        },
      );
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> returnWords(int section) async {
    await readDataBase();

    if (db != null) {
      final List<Map<String, dynamic>> maps = await db!.rawQuery(
          "SELECT CAST(rank AS INT) AS rank, word FROM $tableName WHERE rank_seg = $section");
      return List.generate(maps.length, (i) {
        return {
          'rank': maps[i]['rank'] as int,
          'word': maps[i]['word'] as String
        };
      });
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> getWordInfo(int index) async {
    await readDataBase();

    if (db == null) {
      return {};
    }
    final List<Map<String, dynamic>> result =
        await db!.rawQuery("SELECT * FROM $tableName WHERE rank = $index");
    if (result.isNotEmpty) {
      final Map<String, dynamic> map = result[0];
      return {
        'word': map['word'] as String,
        'word_japanese': map['word_japanese'] as String,
        'pos_full': map['pos_full'] as String,
        'pronounce': map['pronounce'] as String,
      };
    }
    return {};
  }

  Future<List<String>> getRandomWords(List sectionList, int getNum) async {
    await readDataBase();

    if (db == null) {
      return [];
    }
    final List<Map<String, dynamic>> result = await db!.rawQuery(
        "SELECT word FROM $tableName WHERE level IN ('${sectionList.join('\',\'')}') ORDER BY RANDOM() LIMIT $getNum");
    if (result.isNotEmpty) {
      return result.map((map) => map['word'] as String).toList();
    }
    return [];
  }
}
