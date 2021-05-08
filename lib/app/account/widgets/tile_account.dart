import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';

class TileAccount extends StatelessWidget {
  final Account account;

  const TileAccount(this.account);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black12,
            child: CachedNetworkImage(
              imageUrl: account.avatarUrl != null ? account.avatarUrl : '',
              imageBuilder: (context, imageProvider) => Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.account_circle),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(account.name, style: TextStyle(fontWeight: FontWeight.bold)),
              if (account.isCoach) Text("[${Languages.coach()}]"),
            ],
          ),
        ],
      ),
    );
  }
}
