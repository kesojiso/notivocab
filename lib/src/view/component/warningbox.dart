import 'package:flutter/material.dart';
import 'package:notivocab/src/constants.dart';

class Warningbox extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  const Warningbox(
      {super.key, required this.titleText, required this.subtitleText});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListTile(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Center(
          child: Text(
            titleText,
            style: const TextStyle(color: Colors.red),
          ),
        ),
        subtitle: Center(child: Text(subtitleText)),
        tileColor: buttonColor,
      ),
    );
  }
}
