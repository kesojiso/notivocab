import 'package:flutter/material.dart';
import 'package:notivocab/src/constants.dart';

Card defaultCard(String text, void Function()? onPressed) {
  return Card(
    color: buttonColor,
    child: ListTile(
      leading: const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 30, 0), child: Icon(Icons.book)),
      title: Text(text, style: buttonTextStyle),
      onTap: () {},
    ),
  );
}
