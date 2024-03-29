import 'package:bot_toast/bot_toast.dart';
import 'package:fitable/app/account/cubit/my_account/my_account_cubit.dart';
import 'package:fitable/app/account/cubit/my_avatar/my_avatar_cubit.dart';
import 'package:fitable/app/account/repositories/account_repository.dart';
import 'package:fitable/app/account/repositories/avatar_repository.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/auth/repositories/auth_repository.dart';
import 'package:fitable/app/home/repositories/product_repository.dart';
import 'package:fitable/app/settings/cubit/dark_mode_cubit.dart';
import 'package:fitable/app/settings/cubit/locale_cubit.dart';
import 'package:fitable/config/themes/custom_theme.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'config/injectable/injection.dart';
import 'config/routes/routes.gr.dart';
import 'constants/constants.dart';

void main() async {
  // await WidgetsFlutterBinding.ensureInitialized();
  await FlutterServicesBinding.ensureInitialized(); //Todo temporary solution for hydrated bloc
  configureDependencies(Env.dev);
  setPathUrlStrategy();

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp()),
    createStorage: () async {
      return HydratedStorage.build(
        storageDirectory:
            kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
      );
    },
    // storage: storage,
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => getIt<AuthRepository>(),
        ),
        RepositoryProvider<AccountRepository>(
          create: (_) => getIt<AccountRepository>(),
        ),
        RepositoryProvider<AvatarRepository>(
          create: (_) => getIt<AvatarRepository>(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (_) => getIt<ProductRepository>(),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<DarkModeCubit>(
              create: (_) => DarkModeCubit(),
            ),
            BlocProvider<LocaleCubit>(
              create: (_) => LocaleCubit(),
            ),
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(
                authRepository: getIt<AuthRepository>(),
              ),
            ),
          ],
          child: Builder(builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<MyAccountCubit>(
                  create: (_) => MyAccountCubit(
                    accountRepository: getIt<AccountRepository>(),
                    // authBloc: getIt<AuthBloc>(),
                    authBloc: context.read<AuthBloc>(),
                  ),
                ),
                BlocProvider<MyAvatarCubit>(
                  create: (_) => MyAvatarCubit(
                    avatarRepository: getIt<AvatarRepository>(),
                    // authBloc: getIt<AuthBloc>(),
                    authBloc: context.read<AuthBloc>(),
                  ),
                ),
              ],
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                builder: (context, widget) => _build(widget, context, botToastBuilder),
                title: Strings.app_name(),
                locale: context.watch<LocaleCubit>().state,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en', ''), // English, no country code
                  Locale('pl', ''), // Polish, no country code
                ],
                theme: CustomTheme.lightTheme,
                darkTheme: CustomTheme.darkTheme,
                themeMode: context.watch<DarkModeCubit>().state ? ThemeMode.dark : ThemeMode.light,
                routerDelegate: _appRouter.delegate(
                  navigatorObservers: () => [
                    BotToastNavigatorObserver(),
                  ],
                ),
                routeInformationParser: _appRouter.defaultRouteParser(),
              ),
            );
          })),
    );
  }

  Widget _build(Widget? widget, BuildContext context, TransitionBuilder botToastBuilder) {
    widget = ResponsiveWrapper.builder(
      ClampingScrollWrapper.builder(context, widget!),
      breakpoints: const [
        ResponsiveBreakpoint.resize(350, name: MOBILE),
        ResponsiveBreakpoint.autoScale(600, name: TABLET),
        ResponsiveBreakpoint.resize(800, name: DESKTOP),
        ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
      ],
    );
    widget = botToastBuilder(context, widget);
    return widget;
  }
}
