import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/common_widgets/fitable_header.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      child: ProviderScope(child: MyApp()),
      supportedLocales: [
        Locale('pl'),
        Locale('en'),
      ],
      path: 'resources/language.csv',
      saveLocale: true,
      useOnlyLangCode: true,
      assetLoader: CsvAssetLoader(),
      fallbackLocale: Locale('pl'),
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

    // if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS)
    //   return MaterialApp(
    //     // debugShowCheckedModeBanner: false,
    //     title: 'Fitable',
    //     localizationsDelegates: context.localizationDelegates,
    //     supportedLocales: context.supportedLocales,
    //     locale: context.locale,
    //     theme: ThemeData(
    //       fontFamily: 'Georgia',
    //       primaryColor: Colors.lightBlue[800],
    //       // primarySwatch: Colors.indigo,
    //     ),
    //     home: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           FitableHeader(),
    //           Image.asset("resources/images/work_in_progress.jpg"),
    //         ],
    //       ),
    //     ),
    //   );

    return Consumer(builder: (context, watch, child) {
      Preference preference;
      watch(providerPreference).whenData((value) => preference = value);

      return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Fitable',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'Georgia',
          primarySwatch: Colors.indigo,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: (preference?.darkMode ?? false) ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        routes: routes,
      );
    });
  }
}
