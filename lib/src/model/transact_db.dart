import 'package:flutter/material.dart';
import 'package:notivocab/src/model/copy_db_from_asset.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TransactDB {
  final String dbName;
  final String tableName;
  Database? db;
  TransactDB(this.dbName, this.tableName);

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
        readOnly: true,
      );
    } catch (e) {
      debugPrint("READ_DB_ERROR: $e");
    }
  }

  Future<int> returnSectionCount() async {
    await readDataBase();

    if (db != null) {
      final List<Map<String, dynamic>> maps = await db!.rawQuery(
          "SELECT DISTINCT rank_seg FROM $tableName ORDER BY rank_seg ASC");
      return maps.length;
    } else {
      return 0;
    }
  }

  Future<List<Map<String, String>>> returnWords(int section) async {
    await readDataBase();

    if (db != null) {
      final List<Map<String, dynamic>> maps = await db!.rawQuery(
          "SELECT CAST(rank AS TEXT) AS rank, word FROM $tableName WHERE rank_seg = $section");
      return List.generate(maps.length, (i) {
        return {
          'rank': maps[i]['rank'] as String,
          'word': maps[i]['word'] as String
        };
      });
    } else {
      return [];
    }
  }
}
