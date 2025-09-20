
import 'package:dalell/utils/command.dart';
import 'package:dalell/utils/result.dart';
import 'package:flutter/material.dart';

import 'theme_repository.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(this._themeRepository) {
    load = Command0(_load)..execute();
    toggle = Command0(_toggle);
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  ThemeData get currentTheme => _isDarkMode ? darkTheme : ligthTheme;

  void toggleTheme() {
    _toggle();
    notifyListeners();
  }

    final ThemeRepository _themeRepository;


  late final Command0<void> load;

  late final Command0<void> toggle;

  /// Load the current theme setting from the repository
  Future<Result<void>> _load() async {
    try {
      final result = await _themeRepository.isDarkMode();
      if (result is Ok<bool>) {
        _isDarkMode = result.value;
      }
      return result;
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  /// Toggle the theme setting
  Future<Result<void>> _toggle() async {
    try {
      _isDarkMode = !_isDarkMode;
      return await _themeRepository.setDarkMode(_isDarkMode);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}

final ThemeData ligthTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'GoogleFonts',
  primaryColor: Colors.teal,
  scaffoldBackgroundColor: Colors.grey[100],
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
  cardTheme: CardThemeData(
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
      textStyle: TextStyle(
        fontFamily: 'GoogleFonts',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'GoogleFonts',
  primaryColor: Colors.teal,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
  cardTheme: CardThemeData(
    elevation: 8,
    shadowColor: Colors.white.withAlpha(128),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontFamily: 'GoogleFonts',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
);

ThemeData appTheme() {
  return ThemeData(
    brightness: Brightness.light,
    fontFamily: 'GoogleFonts',
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[100],
    // textTheme: TextTheme({TextStyle(fontFamily: 'GoogleFonts' ),}),
    cardTheme: CardThemeData(
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
        textStyle: TextStyle(
          fontFamily: 'GoogleFonts',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
