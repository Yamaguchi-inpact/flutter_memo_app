import 'package:flutter/material.dart';

Widget buildBodyText(context, _counter) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'You have pushed the button this many times:',
        ),
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    ),
  );
}

ButtonStyle buttonStyle(Color borderColor, Color backgroundColor) {
  return ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      side: BorderSide(
        color: borderColor,
      ),
      primary: backgroundColor);
}