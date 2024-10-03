import 'package:flutter/material.dart';

class AppColor {
  static Color secondaryColor(context){
    return Theme.of(context).colorScheme.secondary;
  }

  static Color tertiaryColor(context){
    return Theme.of(context).colorScheme.tertiary;
  }

  static const primaryColor = Color.fromARGB(255, 230, 74, 25);
}