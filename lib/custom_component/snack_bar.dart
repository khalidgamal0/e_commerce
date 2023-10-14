import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message, Color backgroundColor,Color messageColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Center(child: Text(message,style: TextStyle(color: messageColor))),
    ),
  );
}