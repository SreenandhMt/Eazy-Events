import 'package:event_manager/utils/dark_check.dart';
import 'package:flutter/material.dart';

class AppColor {
  static Color thickcolor(context){
    return isDarkTheme(context)? const Color.fromARGB(255, 48, 48, 48):Colors.green.shade400;
  }

  static Color secondaryColor(context){
    return Theme.of(context).colorScheme.secondary;
  }

  static Color tertiaryColor(context){
    return Theme.of(context).colorScheme.tertiary;
  }

  static const primaryColor = Color.fromARGB(255, 230, 74, 25);
}