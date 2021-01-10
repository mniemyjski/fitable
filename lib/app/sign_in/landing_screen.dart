import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/sign_in/sign_in_screen.dart';
import 'package:fitable/app/sign_in/widgets/create_account.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerWidget {
  final Widget body;

  LandingScreen({@required this.body});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(providerAuthState);
    final account = watch(providerAccount);

    return authStateChanges.when(
      data: (user) {
        if (user != null) {
          return account.when(
            data: (account) {
              if (account != null) {
                return body;
              } else {
                return CreateAccount();
              }
            },
            loading: () => Scaffold(
              body: Center(
                child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
              ),
            ),
            error: (err, stack) => Scaffold(
              body: Center(child: Text('Error: $err')),
            ),
          );
        } else {
          return SignInScreen();
        }
      },
      loading: () => Scaffold(
        body: Center(
          child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
