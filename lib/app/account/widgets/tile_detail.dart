import 'package:fitable/models/account_model.dart';
import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/utilities/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitable/utilities/providers.dart';

class TileDetail extends StatelessWidget {
  final AccessLevel access;
  final String name;
  final String value;
  final Account account;

  const TileDetail({Key key, this.access, this.name, this.value, this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final myAccount = watch(providerAccount).data.value;

      return watch(providerFollowers).when(
          data: (followers) {
            if (!Validators.isAccess(access, myAccount.uid, account, followers)) return Container();
            return Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: <Widget>[
                  if (Validators.isAccess(access, myAccount.uid, account, followers)) Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(value),
                ],
              ),
            );
          },
          loading: () => Container(),
          error: (e, h) => Container());
    });
  }
}
