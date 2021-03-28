import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitable/common_widgets/fitable_header.dart';
import 'package:fitable/common_widgets/monetize_ad.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fitable/services/sync_health.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [Locale('pl', 'PL'), Locale('en', 'US')],
        path: 'resources/language.csv',
        assetLoader: CsvAssetLoader(),
        fallbackLocale: Locale('pl', 'PL'),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    // ]);

    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS)
      return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Fitable',
        theme: ThemeData(
          fontFamily: 'Georgia',
          primaryColor: Colors.lightBlue[800],
          // primarySwatch: Colors.indigo,
        ),
        home: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FitableHeader(),
              Image.asset("resources/images/work_in_progress.jpg"),
            ],
          ),
        ),
      );

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Fitable',
      theme: ThemeData(
        fontFamily: 'Georgia',
        // primaryColor: Colors.lightBlue[800],
        // accentColor: Colors.lightBlue[700],
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}
