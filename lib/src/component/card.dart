import 'package:flutter/material.dart';
import 'package:notivocab/src/constants.dart';

Card defaultCard(String text, void Function()? onPressed) {
  return Card(
    color: buttonColor,
    child: ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.book),
          Text(text, style: buttonTextStyle),
          const Icon(Icons.add_circle)
        ],
      ),
      onTap: () {
        onPressed!();
      },
    ),
  );
}

Card wordCard(String index, String text, void Function()? onPressed) {
  return Card(
    color: buttonColor,
    child: ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$index:", style: buttonTextStyle),
          Text(text, style: buttonTextStyle),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
      onTap: () {
        onPressed!();
      },
    ),
  );
}
