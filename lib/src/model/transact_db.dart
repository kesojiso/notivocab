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
      final List<Map<String, dynamic>> maps =
          await db!.query(tableName, columns: ['rank_seg'], distinct: true);
      return maps.length;
    } else {
      return 0;
    }
  }
}
