import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/repositories/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';
import '../../account/cubit/my_account_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Strings.home()),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          CustomButton(
              onPressed: () {
                context.read<AccountRepository>().updateAvatar2();
              },
              child: Text('test')),
        ],
      ),
    );
  }
}
