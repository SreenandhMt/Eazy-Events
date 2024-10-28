import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(brightness: Brightness.dark,secondary: Colors.grey.shade800,tertiary: Colors.grey.shade700),
    primaryColor: Colors.deepOrange[700],
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black,elevation: 0),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepOrange[700],
      disabledColor: Colors.grey,
    ),

    textTheme: TextTheme(
      headlineLarge: GoogleFonts.nunito(color: Colors.white),
      headlineMedium: GoogleFonts.nunito(color: Colors.white70),
      headlineSmall: GoogleFonts.nunito(color: Colors.white60),
      bodyLarge: GoogleFonts.nunito(color: Colors.white),
      bodyMedium: GoogleFonts.nunito(color: Colors.white70),
      bodySmall: GoogleFonts.nunito(color: Colors.white60),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white70,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: Colors.grey.shade200,
      unselectedItemColor: Colors.grey,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade700,
      hintStyle: GoogleFonts.nunito(),
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 0.5)),
    ),);

  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.dark(brightness: Brightness.light,secondary: Colors.grey.shade300,tertiary: Colors.grey.shade300),
    brightness: Brightness.light,
    primaryColor: Colors.deepOrange[700],
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade100,elevation: 0,actionsIconTheme:  const IconThemeData(
      color: Colors.black87,
    ),
    titleTextStyle: GoogleFonts.nunito(color: Colors.black54),
    toolbarTextStyle:GoogleFonts.nunito(color: Colors.black54) 
    ,iconTheme: const IconThemeData(
      color: Colors.black87,
    ),),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepOrange[700],
      disabledColor: Colors.grey,
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.nunito(color: Colors.black),
      headlineMedium: GoogleFonts.nunito(color: Colors.black87),
      headlineSmall: GoogleFonts.nunito(color: Colors.black54),
      bodyLarge: GoogleFonts.nunito(color: Colors.black),
      bodyMedium: GoogleFonts.nunito(color: Colors.black87),
      bodySmall: GoogleFonts.nunito(color: Colors.black54),
    ),
    primaryIconTheme: const IconThemeData(
      color:  Colors.black87,
    ),
    iconTheme: const IconThemeData(
      color:  Colors.black87,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 208, 208, 208),
      selectedItemColor: Colors.grey.shade300,
      unselectedItemColor: Colors.grey.shade700,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade200,
      iconColor: Colors.black54,
      prefixIconColor: Colors.black54,
      suffixIconColor: Colors.black54,
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 0.5)),
      hintStyle: GoogleFonts.nunito(color: Colors.black54),
    ),);
}
