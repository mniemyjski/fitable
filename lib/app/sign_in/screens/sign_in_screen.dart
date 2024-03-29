import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/app/failure/models/failure_model.dart';
import 'package:fitable/app/sign_in/cubit/sign_in_cubit.dart';
import 'package:fitable/constants/strings.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:fitable/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKeyEmail = GlobalKey();
  final GlobalKey<FormState> _formKeyPassword = GlobalKey();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocProvider(
      create: (ctx) => SignInCubit(
        authBloc: context.read<AuthBloc>(),
      ),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: state.whenOrNull(
                  reset: () => AppBar(
                          leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () =>
                            context.read<SignInCubit>().changeFormSignIn(),
                      ))),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      formKey: _formKeyEmail,
                      controller: _controllerEmail,
                      labelText: AppLocalizations.of(context)!.email,
                      validator: (v) => Validators.email(v),
                      icon: Icons.email,
                    ),
                    if (state != SignInState.reset())
                      CustomTextField(
                        formKey: _formKeyPassword,
                        controller: _controllerPassword,
                        labelText: AppLocalizations.of(context)!.password,
                        validator: (v) => Validators.password(v),
                        icon: Icons.lock,
                        obscureText: true,
                      ),
                    CustomButton(
                      onPressed: () => _singIn(context),
                      child: Center(
                        child: Text(_getTexts(state)),
                      ),
                    ),
                    if (state == SignInState.sign_in())
                      TextButton(
                          onPressed: () =>
                              context.read<SignInCubit>().changeFormReset(),
                          child: Text(
                            AppLocalizations.of(context)!.forgotYourPassword,
                            style: TextStyle(color: Colors.white),
                          )),
                    if (state == SignInState.sign_up())
                      TextButton(
                          onPressed: () =>
                              context.read<SignInCubit>().changeFormSignIn(),
                          child: Text(AppLocalizations.of(context)!.signIn,
                              style: TextStyle(color: Colors.white))),
                    if (state == SignInState.sign_in())
                      TextButton(
                          onPressed: () =>
                              context.read<SignInCubit>().changeFormSignUp(),
                          child: Text(
                              AppLocalizations.of(context)!.needRegister,
                              style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getTexts(SignInState state) {
    if (state == SignInState.sign_in()) {
      return AppLocalizations.of(context)!.signIn;
    }
    if (state == SignInState.sign_up()) {
      return AppLocalizations.of(context)!.signUp;
    }
    if (state == SignInState.reset()) {
      return AppLocalizations.of(context)!.resetPassword;
    }
    return '';
  }

  _singIn(BuildContext context) async {
    if (_formKeyEmail.currentState!.validate() &&
        _formKeyPassword.currentState!.validate()) {
      Failure? failure = await context.read<SignInCubit>().sign(
            email: _controllerEmail.text,
            password: _controllerPassword.text,
          );

      if (failure != null) {
        customFlashBar(failure.massage!);
      }
    }
  }
}
