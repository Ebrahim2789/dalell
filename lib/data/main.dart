import 'dart:io';

import 'package:dalell/data/main_app_viewmodel.dart';
import 'package:dalell/data/repositories/product_repostory.dart';
import 'package:dalell/data/repositories/theme_repository.dart';
import 'package:dalell/data/services/database_service.dart';
import 'package:dalell/data/services/shared_preferences_service.dart';
import 'package:dalell/data/ui/theme_config/viewmodel/theme_switch_viewmodel.dart';
import 'package:dalell/data/ui/theme_config/widgets/theme_switch.dart';
import 'package:dalell/data/ui/viewmodel/todo_list_screen.dart';
import 'package:dalell/data/ui/widget/todo_list_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';



// #docregion MainTheme
// #docregion MainProduct
void main() {
  // #enddocregion MainTheme
  late DatabaseService databaseService;
  if (kIsWeb) {
    throw UnsupportedError('Platform not supported');
  } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    // Initialize FFI SQLite
    sqfliteFfiInit();
    databaseService = DatabaseService(databaseFactory: databaseFactoryFfi);
  } else {
    // Use default native SQLite
    databaseService = DatabaseService(databaseFactory: databaseFactory);
  }

  // #docregion MainTheme
  runApp(
    MainApp(
      // #enddocregion MainProduct
      themeRepository: ThemeRepository(SharedPreferencesService()),
      // #enddocregion MainTheme
      // #docregion MainProduct
      productRepository: ProductRepository(database: databaseService),
      // #docregion MainTheme
    ),
  );
}
// #enddocregion MainProduct
// #enddocregion MainTheme

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.themeRepository,
    required this.productRepository,
  });

  final ThemeRepository themeRepository;
  final ProductRepository productRepository;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late MainAppViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MainAppViewModel(widget.themeRepository);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // #docregion ListenableBuilder
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return MaterialApp(
          theme: _viewModel.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: child,
        );
      },
      // #enddocregion ListenableBuilder
      child: Scaffold(
        appBar: AppBar(
          actions: [
            // #docregion AddThemeSwitch
            ThemeSwitch(
              viewmodel: ThemeSwitchViewModel(widget.themeRepository),
            ),
            // #enddocregion AddThemeSwitch
          ],
          title: const Text('Product List'),
        ),
        // #docregion ProductListScreen
        body: ProductListScreen(
          viewModel: ProductListViewModel(ProductRepository: widget.productRepository),
        ),
        // #enddocregion ProductListScreen
      ),
    );
  }
}
