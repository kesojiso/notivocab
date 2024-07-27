import 'package:flutter/material.dart';
import 'package:notivocab/src/constants.dart';

Card defaultCard(String text, void Function()? onPressed) {
  return Card(
    child: ListTile(
      // leading: leading,
      title: Text(text, style: normalTextStyle),
      onTap: () {},
    ),
  );
}
