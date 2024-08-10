import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/constants.dart';
import 'package:notivocab/src/model/copy_db_from_asset.dart';
import 'src/router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    for (final dbName in assetDBList) {
      copyDBFromAsset(dbName);
    }
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
