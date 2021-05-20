import 'package:fitable/models/account_model.dart';
import 'package:fitable/app/sign_in/sign_in_screen.dart';
import 'package:fitable/app/sign_in/widgets/create_account.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerWidget {
  final Widget body;

  LandingScreen({@required this.body});

  ETypeConnStatus conn = ETypeConnStatus.loading;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(providerAuthState);
    final account = watch(providerAccount);

    authStateChanges.whenData((user) {
      if (user != null) {
        account.whenData((value) {
          if (value != null) {
            conn = ETypeConnStatus.success;
          } else {
            conn = ETypeConnStatus.createAccount;
          }
        });
      } else {
        conn = ETypeConnStatus.signInScreen;
      }
    });

    if (conn == ETypeConnStatus.loading)
      return Scaffold(
        body: Center(
          child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
        ),
      );

    if (conn == ETypeConnStatus.success) return body;
    if (conn == ETypeConnStatus.createAccount) return CreateAccount();
    return SignInScreen();
  }
}
