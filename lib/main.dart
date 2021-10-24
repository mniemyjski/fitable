import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/auth/repositories/auth_repository.dart';
import 'package:fitable/app/dark_mode/dark_mode_cubit.dart';
import 'package:fitable/config/themes/custom_theme.dart';
import 'package:fitable/constants/strings.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:path_provider/path_provider.dart';

import 'config/injectable/injection.dart';
import 'config/routes/routes.gr.dart';

void main() async {
  configureDependencies(Env.prod);
  // WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setPathUrlStrategy();
  Bloc.observer = SimpleBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('pl'),
        Locale('en'),
      ],
      path: 'assets/languages.csv',
      saveLocale: true,
      useOnlyLangCode: true,
      assetLoader: CsvAssetLoader(),
      fallbackLocale: Locale('pl'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => getIt<AuthRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: getIt<AuthRepository>(),
            ),
          ),
          BlocProvider<DarkModeCubit>(
            create: (context) => DarkModeCubit(),
          ),
        ],
        child: BlocBuilder<DarkModeCubit, bool>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: true,
              builder: (context, widget) => ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                breakpoints: const [
                  ResponsiveBreakpoint.resize(350, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(600, name: TABLET),
                  ResponsiveBreakpoint.resize(800, name: DESKTOP),
                  ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                ],
              ),
              title: Strings.app_name(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: CustomTheme.lightTheme,
              darkTheme: CustomTheme.darkTheme,
              themeMode: state ? ThemeMode.dark : ThemeMode.light,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
            );
          },
        ),
      ),
    );
  }
}
