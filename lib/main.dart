import 'package:flutter/material.dart';
import 'package:dalell/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<DataCache>(create: (_) => DataCache()),
          ChangeNotifierProvider<Something>(create: (_) => Something()),
        ],
        child: MaterialApp(
          onGenerateTitle: (context) => "Random App",
          initialRoute: RouteGenerator.homePages,
          
          
// 2.
          onGenerateRoute: RouteGenerator.generateRoute, // 3.
          debugShowCheckedModeBanner: false,
        ));
  }
}

class Something with ChangeNotifier {
  final description = "something is better than nothing";
  final descriptionCache = {};
}

class DataCache {}
