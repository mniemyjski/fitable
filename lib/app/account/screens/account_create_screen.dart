import 'package:fitable/app/account/cubit/my_account/my_account_cubit.dart';
import 'package:fitable/app/auth/bloc/auth_bloc.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../failure/models/failure_model.dart';
import 'package:fitable/utilities/utilities.dart';

class AccountCreateScreen extends StatefulWidget {
  const AccountCreateScreen({Key? key}) : super(key: key);

  @override
  State<AccountCreateScreen> createState() => _AccountCreateScreenState();
}

class _AccountCreateScreenState extends State<AccountCreateScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  final GlobalKey<FormState> _formKey1 = GlobalKey();
  final GlobalKey<FormState> _formKey2 = GlobalKey();
  final GlobalKey<FormState> _formKey3 = GlobalKey();

  @override
  void dispose() {
    _controllerName.dispose();
    _controller2.dispose();
    _controller3.dispose();

    super.dispose();
  }

  _singIn(BuildContext context) async {
    if (_formKey1.currentState!.validate()) {
      try {
        await context.read<MyAccountCubit>().create(_controllerName.text);
      } on Failure catch (failure) {
        customFlashBar(failure.massage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await context.read<AuthBloc>().signOut();
        return false;
      },
      child: Scaffold(
        appBar: customAppBar(title: AppLocalizations.of(context)!.createAccount),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              CustomTextField(
                formKey: _formKey1,
                controller: _controllerName,
                labelText: AppLocalizations.of(context)!.name,
              ),
              // CustomTextField(
              //   formKey: _formKey2,
              //   controller: _controller2,
              //   labelText: Strings.email(),
              // ),
              // CustomTextField(
              //   formKey: _formKey3,
              //   controller: _controller3,
              //   labelText: Strings.email(),
              // ),
              CustomButton(
                onPressed: () => _singIn(context),
                child: Center(child: Text(AppLocalizations.of(context)!.save)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
