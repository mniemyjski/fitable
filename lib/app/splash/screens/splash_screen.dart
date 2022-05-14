import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/account/cubit/my_account/my_account_cubit.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:fitable/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (prevState, state) => prevState != state,
            listener: (_, state) {
              state.whenOrNull(
                unauthenticated: () {
                  context.router.popUntilRoot();
                  context.router.push(const SignInRoute());
                },
              );
            },
          ),
          BlocListener<MyAccountCubit, MyAccountState>(
            listenWhen: (prevState, state) => prevState != state,
            listener: (_, state) {
              state.whenOrNull(
                unCreated: () => context.router.push(const AccountCreateRoute()),
                created: (data) => context.router.push(const HomeRoute()),
              );
            },
          ),
        ],
        child: const Scaffold(
          body: Center(child: CustomLoadingWidget()),
        ),
      ),
    );
  }
}
