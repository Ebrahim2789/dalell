
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
         fontFamily: 'GoogleFonts', 
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[100],
    // textTheme: TextTheme({TextStyle(fontFamily: 'GoogleFonts' ),}),
    cardTheme:
    
     CardThemeData(
      elevation: 8,
      shadowColor: Colors.black.withAlpha(128),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontFamily: 'GoogleFonts', ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}

