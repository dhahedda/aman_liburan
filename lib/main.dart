import 'dart:async';

import 'package:aman_liburan/blocs/login/login_bloc.dart';
import 'package:aman_liburan/screens/account/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aman_liburan/app_base_configuration.dart';
import 'package:aman_liburan/app_localizations.dart';
import 'package:aman_liburan/screens/search/search_page.dart';
import 'package:aman_liburan/screens/splash_screen.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final FirebaseApp firebaseApp = await Firebase.initializeApp(
  //   name: 'db2',
  //   options: FirebaseOptions(
  //     appId: '1:828517044655:android:297bd1ec717d0312d89f5a',
  //     apiKey: ' AIzaSyDT0LhuPk5X69D6Ozsr7eBai7Lm0KxOxg8 ',
  //     projectId: 'aman-liburan',
  //     messagingSenderId: '828517044655',
  //     databaseURL: 'https://aman-liburan.firebaseio.com/',
  //   ),
  // );
  runApp(NiGaijin());
}

class NiGaijin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    // var AppLocalizations;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (ctx) => LoginBloc())
        // ChangeNotifierProvider(create: (BuildContext context) => UserServices()),
      ],
      child: MaterialApp(
        title: 'Aman Liburan',
        theme: ThemeData(
          fontFamily: 'Poppins',
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
          '/login-page': (BuildContext context) => LoginPage(),
          '/app-base-configuration': (BuildContext context) => AppBaseConfiguration(),
          '/search-page': (BuildContext context) => SearchPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
