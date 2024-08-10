import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> copyDBFromAsset(String dbName) async {
  final dbPath = join(await getDatabasesPath(), dbName);
  final file = File(dbPath);
  if (!await file.exists()) {
    final dbInAsset = await rootBundle.load('asset/$dbName');
    final bytes = dbInAsset.buffer.asUint8List();
    await file.writeAsBytes(bytes);
  }
}
