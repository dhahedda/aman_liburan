import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aman_liburan/app_base_configuration.dart';
import 'package:aman_liburan/app_localizations.dart';
import 'package:aman_liburan/screens/account/account_page.dart';
import 'package:aman_liburan/screens/search/search_page.dart';
import 'package:aman_liburan/screens/signin/signin_page.dart';
import 'package:aman_liburan/screens/splash_screen.dart';

Future<void> main() async => runApp(NiGaijin());

class NiGaijin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    // var AppLocalizations;
    return MaterialApp(
      title: 'Aman Liburan',
      theme: ThemeData(
        fontFamily: 'Nunito',
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
      ),
      // How to use localization:
      // 1. Insert this as text string ---> Text(AppLocalizations.of(context).translate('first_string'))
      //    The translations are located in assets/languages/xx-XX.json
      // 2. Insert these lines of code to the closest parent MaterialApp
      // ======================== START OF CODE ========================
      // List all of the app's supported locales here
      supportedLocales: [
        Locale('en', 'US'),
        // Locale('ja', 'JP'),
        Locale('id', 'ID'),
      ],
      // Choose the language here
      // If not specified, will default to Locale('en', 'US')
      locale: Locale('en', 'US'),
      // locale: Locale('zh', 'CN'),

      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      // ======================== END OF CODE ========================
      home: SplahScreen(),
      routes: <String, WidgetBuilder>{
        // Routing Configuration
        // TODO update routes
        // TODO allow location permission transition is not smooth
        '/login-page': (BuildContext context) => SigninPage(),
        '/app-base-configuration': (BuildContext context) => AppBaseConfiguration(),
        '/account-page': (BuildContext context) => AccountPage(),
        '/search-page': (BuildContext context) => SearchPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
