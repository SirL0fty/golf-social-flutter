import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.red, Color textColor = Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: DefaultTextStyle(
        style: TextStyle(color: textColor, fontSize: 16),
        child: Text(message),
      ),
    ),
  );
}
