import 'package:dalell/config/theme/themedata.dart';
import 'package:dalell/localizations/local.dart';
import 'package:dalell/views/user/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:dalell/routes/routes.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/shared_preferences_service.dart';
import 'config/theme/theme_repository.dart';
import 'views/user/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  await FlutterLocalization.instance.ensureInitialized();
  runApp(MyApp(
    themeRepository: ThemeRepository(SharedPreferencesService()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.themeRepository,
  });

  final ThemeRepository themeRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//   localizationsDelegates: [
// const CustomLocalizationsDelegate(),
// GlobalMaterialLocalizations.delegate,
// GlobalWidgetsLocalizations.delegate,
// ],
// supportedLocales: [
// const Locale('en', ''),

// const Locale('es', ''),
// ],
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('km', AppLocale.KM),
        const MapLocale('ja', AppLocale.JA),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    checkLogin();


    // print(_viewModel.isDarkMode);

    super.initState();
  }

  @override
  void dispose() {
 
    super.dispose();
  }

// the setState function here is a must to add
  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider(
      create: (_) =>ThemeNotifier(ThemeRepository(SharedPreferencesService())) ,
      child: Consumer<ThemeNotifier>(builder: 
      
      (context,themeNotifier,child){
        return    BlocProvider(
          create: (context) => AuthBloc()..add(CheckAuthStatus()),
          child: MaterialApp(
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,

            onGenerateTitle: (context) => "Random App",

            theme:themeNotifier.currentTheme,
            initialRoute: RouteGenerator.root,
// 2.
            onGenerateRoute: RouteGenerator.generateRoute, // 3.
            debugShowCheckedModeBanner: false,

            home: child,
          ),
        );
      }),
      
    

    
    );
  }
}
