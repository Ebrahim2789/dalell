import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/auth/auth_screen.dart';
import '../features/settings/settings_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    auth: (context) => const AuthScreen(),
    settings: (context) => const SettingsScreen(),
  };
}
