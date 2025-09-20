import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class CustomLocalizations {
  CustomLocalizations(this.locale);
  final Locale locale;
  static CustomLocalizations? of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  static Map<String, Map<String, String>> _resources = {
    'en': {'title': 'Demo', 'message': 'Hello World'},
    'es': {
      'title': 'Manifestación',
      'message': 'Hola Mundo',
    },
  };
  String? get title {
    return _resources[locale.languageCode]?['title'];
  }

  String? get message {
    return _resources[locale.languageCode]?['message'];
  }
}

class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const CustomLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);
  @override
  Future<CustomLocalizations> load(Locale locale) {
    return SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}

mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> EN = {title: 'Localization'};
  static const Map<String, dynamic> KM = {title: 'ការធ្វើមូលដ្ឋានីយកម្ម'};
  static const Map<String, dynamic> JA = {title: 'ローカリゼーション'};
}



//     To display the value from the Map data, just use the getString extension by providing the context (the AppLocale.title is the constant from mixin class above)

// AppLocale.title.getString(context);

// Extras

//     You also can get the language name too. If you don't specify the language code for the function, it will return the language name depend on the current app locale

// localization.getLanguageName(languageCode: 'en');  // English
// localization.getLanguageName(languageCode: 'km');  // ភាសាខ្មែរ
// localization.getLanguageName(languageCode: 'ja');  // 日本語

// localization.getLanguageName();  // get language name depend on current app locale

//     If you need to use locale identifier in some case, you can get it from the current locale. The identifier format is languageCode_scriptCode_countryCode. For scriptCode and countryCode are optional, this might return only the languageCode.

// localization.currentLocale.localeIdentifier;

// Some update note 


// You can provide the font family in the MapLocale model at the init() function that can be from Assets or GoogleFonts package.

// // font family from asset
// MapLocale('en', AppLocale.EN, fontFamily: 'MuseoSans');

// // or from GoogleFonts package
// MapLocale('en', AppLocale.EN, fontFamily: GoogleFonts.lato().fontFamily);

// Lastly, provide the font family to the MaterialApp's ThemeData

// @override
// Widget build(BuildContext context) {
//     return MaterialApp(
//         supportedLocales: localization.supportedLocales,
//         localizationsDelegates: localization.localizationsDelegates,
//         home: const SettingsScreen(),
//         theme: ThemeData(fontFamily: localization.fontFamily),
//     );
// }
