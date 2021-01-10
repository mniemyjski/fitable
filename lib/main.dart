import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

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

    return MaterialApp(
        title: 'Fitable',
        theme: ThemeData(
          fontFamily: 'Georgia',
          primarySwatch: Colors.indigo,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings));
  }
}
