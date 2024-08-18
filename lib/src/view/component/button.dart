import 'package:flutter/material.dart';
import '../../constants.dart';

Padding defaultButton(String text, void Function()? onPressed) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 10,
          fixedSize: const Size(250, 70),
          backgroundColor: buttonColor),
      child: Text(text, style: buttonTextStyle),
    ),
  );
}
