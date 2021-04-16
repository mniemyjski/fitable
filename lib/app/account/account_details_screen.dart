import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/view_models/account_details_view_model.dart';
import 'package:fitable/app/favorite/models/favorite_model.dart';
import 'package:fitable/common_widgets/custom_scaffold.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountDetailsScreenArguments {
  final Account account;

  AccountDetailsScreenArguments({@required this.account});
}

class AccountDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AccountDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

    return CustomScaffold(
      appBar: AppBar(
        title: Text(args.account.name),
        actions: [
          Consumer(builder: (context, watch, child) {
            final model = watch(providerAccountDetailsViewModel);
            model.isFavorite = false;
            watch(providerFavorite).whenData((favorites) => favorites.forEach((element) => model.favoriteCheck(element, args.account.uid)));
            return IconButton(
              icon: model.isFavorite ? Icon(FontAwesomeIcons.solidHeart) : Icon(FontAwesomeIcons.heart),
              onPressed: () => context.read(providerAccountDetailsViewModel).favoriteButton(context, args.account.uid),
            );
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  child: CachedNetworkImage(
                    imageUrl: args.account.avatarUrl != null ? args.account.avatarUrl : '',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.account_circle,
                      size: 140,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.youtube, color: args.account.youtube != '' ? Colors.red : Colors.grey),
                  onPressed: () => null,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: args.account.instagram != '' ? Colors.blue[800] : Colors.grey),
                  onPressed: () => null,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram, color: args.account.facebook != '' ? Colors.blue[800] : Colors.grey),
                  onPressed: () => null,
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: <Widget>[
                  Text(Constants.gender() + ': ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(args.account.gender.tr()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: <Widget>[
                  Text(Constants.height() + ': ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(args.account.height.toString()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: <Widget>[
                  Text(Constants.date_birth() + ': ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(DateFormat('yyyy-MM-dd').format(args.account.dateBirth)),
                ],
              ),
            ),
            Text(Constants.bio() + ': ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(args.account?.bio ?? ''),
            Divider(),
          ],
        ),
      ),
    );
  }
}
