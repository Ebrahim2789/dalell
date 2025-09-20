import 'package:dalell/config/theme/theme_repository.dart';
import 'package:dalell/config/theme/themedata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({
    super.key,
    required this.themeRepository,
  });

  final ThemeRepository themeRepository;

  @override
  State<AppTheme> createState() => AppThemeState();
}

class AppThemeState extends State<AppTheme> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifeier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text('App Theme'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                themeNotifeier.isDarkMode
                    ? const Text('Dark Mode')
                    : const Text('Light Mode'),
                Switch(
                  value: themeNotifeier.isDarkMode,
                  onChanged: (_) {
                    themeNotifeier.toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


