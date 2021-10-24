import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
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
            listener: (context, state) {
              state.map(
                  initial: (_) => null,
                  authenticated: (_) => context.router.push(const HomeRoute()),
                  unauthenticated: (_) {
                    context.router.popUntilRoot();
                    context.router.push(const SignInRoute());
                  });
            },
          ),
        ],
        child: const Scaffold(
          body: Center(
            child: CustomLoadingWidget(),
          ),
        ),
      ),
    );
  }
}
