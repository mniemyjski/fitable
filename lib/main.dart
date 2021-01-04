import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitable/models/account_model.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/services/database.dart';
import 'package:fitable/view/screens/home/home_screen.dart';
import 'package:fitable/view/screens/landing/landing_screen.dart';
import 'package:fitable/view/screens/settings/settings_screen.dart';
import 'package:fitable/view/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
          StreamProvider(
            lazy: false,
            create: (context) => context.read<AuthBase>().authStateChanges(),
          ),
        ],
        builder: (context, child) {
          final auth = context.watch<AuthBase>();

          return MultiProvider(
              providers: [
                Provider<Database>(create: (context) => FirestoreDatabase(uid: auth.currentUser.uid)),
                StreamProvider(
                  lazy: false,
                  create: (context) => context.read<Database>().userStream(),
                ),
              ],
              builder: (context, snapshot) {
                return MaterialApp(
                  title: 'Fitable',
                  theme: ThemeData(
                    primarySwatch: Colors.indigo,
                  ),
                  initialRoute: '/',
                  routes: {
                    '/': (context) => LandingScreen(),
                    SignInScreen.route: (context) => SignInScreen(),
                    HomeScreen.route: (context) => HomeScreen(),
                    SettingsScreen.route: (context) => SettingsScreen(),
                  },
                );
              });
        });
  }
}
