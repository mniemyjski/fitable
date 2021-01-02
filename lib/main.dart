import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/view/screens/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('pl', 'PL'), Locale('en', 'US')],
      path: 'resources/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthBase>(create: (context) => Auth()),
        ],
        builder: (context, child) {
          return MaterialApp(
            title: 'Fitable',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
            ),
            home: LandingScreen(),
          );
        });
  }
}
