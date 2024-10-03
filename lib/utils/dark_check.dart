import 'package:flutter/material.dart';

bool isDarkTheme(context){
  return Theme.of(context).colorScheme.brightness==Brightness.dark;
}