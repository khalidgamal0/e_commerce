import 'package:flutter/material.dart';

void navigatorAndFinish(Widget pageName,context){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return pageName;
  },), (route) => false);
}