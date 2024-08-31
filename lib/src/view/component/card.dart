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

Card wordsListCard(int index, String text, void Function()? onPressed) {
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

Card singleWordCard(
  int index,
  String word,
  String wordJapanese,
  String posFull,
  String pronounce,
) {
  return Card(
    color: buttonColor,
    child: ListTile(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                word,
                style: textStyleXL,
                softWrap: true,
              ),
            ],
          ),
          Text(
            pronounce,
            style: textStylePronounce,
            softWrap: true,
          ),
          const SizedBox(height: 20),
          Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Text(posFull, style: buttonTextStyle)),
          const SizedBox(height: 20),
          Text(
            wordJapanese,
            style: textStyleL,
            softWrap: true,
          ),
        ],
      ),
    ),
  );
}

Padding quizScopeCard(
    {required bool checked,
    required String title,
    required void Function(bool?)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Card(
      color: checked ? buttonColor : nonActiveColor,
      child: CheckboxListTile(
          value: checked,
          title: SizedBox(
            height: 80,
            child: Center(
              child: Text(
                title,
                style: buttonTextStyle,
              ),
            ),
          ),
          onChanged: onChanged),
    ),
  );
}
