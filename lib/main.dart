import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/cubit/my_account/my_account_cubit.dart';
import 'package:fitable/app/account/cubit/my_avatar/my_avatar_cubit.dart';
import 'package:fitable/app/account/repositories/account_repository.dart';
import 'package:fitable/app/account/repositories/avatar_repository.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/auth/repositories/auth_repository.dart';
import 'package:fitable/app/dark_mode/dark_mode_cubit.dart';
import 'package:fitable/config/themes/custom_theme.dart';
import 'package:fitable/constants/strings.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'config/injectable/injection.dart';
import 'config/routes/routes.gr.dart';

void main() async {
  // await WidgetsFlutterBinding.ensureInitialized();
  await FlutterServicesBinding.ensureInitialized(); //Todo temporary solution for hydrated bloc
  configureDependencies(Env.dev);
  EasyLocalization.ensureInitialized();
  setPathUrlStrategy();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(EasyLocalization(
        supportedLocales: [
          Locale('pl'),
          Locale('en'),
        ],
        path: 'assets/translations',
        saveLocale: false,
        useOnlyLangCode: true,
        fallbackLocale: Locale('en'),
        child: MyApp())),
    storage: storage,
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
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<DarkModeCubit>(
              create: (_) => DarkModeCubit(),
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
                    authBloc: context.read<AuthBloc>(),
                  ),
                ),
                BlocProvider<MyAvatarCubit>(
                  create: (_) => MyAvatarCubit(
                    avatarRepository: getIt<AvatarRepository>(),
                    authBloc: context.read<AuthBloc>(),
                  ),
                ),
              ],
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                builder: (context, widget) => _build(widget, context, botToastBuilder),
                title: Strings.app_name(),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
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
