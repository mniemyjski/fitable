import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/app/account/cubit/my_account/my_account_cubit.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/account/cubit/my_avatar/my_avatar_cubit.dart';
import '../../widgets.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorDark.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: GestureDetector(
            onTap: () {
              context.router.push(const MyAccountRoute());
            },
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 40.0,
                  left: 16.0,
                  child: BlocBuilder<MyAvatarCubit, MyAvatarState>(
                    builder: (context, state) => state.maybeWhen(
                        loaded: (avatar) => CustomAvatar(uint8list: avatar),
                        orElse: () => CustomAvatar()),
                  ),
                ),
                Positioned(
                    bottom: 8.0,
                    left: 16.0,
                    child: BlocBuilder<MyAccountCubit, MyAccountState>(
                      builder: (context, state) {
                        if (state is Created)
                          return Text(
                            state.account.name,
                            style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
                          );
                        return Container();
                      },
                    )),
              ],
            ),
          )),
    );
  }
}
