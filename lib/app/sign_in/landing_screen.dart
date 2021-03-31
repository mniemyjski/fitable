import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/sign_in/sign_in_screen.dart';
import 'package:fitable/app/sign_in/widgets/create_account.dart';
import 'package:fitable/constants/enum.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerWidget {
  final Widget body;

  LandingScreen({@required this.body});

  ConnStatus conn = ConnStatus.loading;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(providerAuthState);
    final account = watch(providerAccount);

    authStateChanges.whenData((user) {
      if (user != null) {
        account.whenData((value) {
          if (value != null) {
            conn = ConnStatus.success;
          } else {
            conn = ConnStatus.createAccount;
          }
        });
      } else {
        conn = ConnStatus.signInScreen;
      }
    });

    if (conn == ConnStatus.loading)
      return Scaffold(
        body: Center(
          child: Container(height: 100, width: 100, child: CircularProgressIndicator()),
        ),
      );

    if (conn == ConnStatus.success) return body;
    if (conn == ConnStatus.createAccount) return CreateAccount();
    return SignInScreen();
  }
}
