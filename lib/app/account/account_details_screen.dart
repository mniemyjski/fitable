import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/models/account_model.dart';
import 'package:fitable/app/account/view_models/account_details_view_model.dart';
import 'package:fitable/app/account/widgets/tile_detail.dart';
import 'package:fitable/models/favorite_model.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';
import 'package:fitable/utilities/providers.dart';

class AccountDetailsScreenArguments {
  final Account account;

  AccountDetailsScreenArguments({@required this.account});
}

void _launchURL(String url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

class AccountDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AccountDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.account.name),
        actions: [
          Consumer(builder: (context, watch, child) {
            final model = watch(providerAccountDetailsViewModel);
            final myAccount = watch(providerAccount).data.value;

            if (myAccount.uid == args.account.uid) return Container();

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
                  onPressed: () => _launchURL(args.account.youtube),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook, color: args.account.facebook != '' ? Colors.blue[800] : Colors.grey),
                  onPressed: () => _launchURL(args.account.facebook),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram, color: args.account.instagram != '' ? Colors.purple[800] : Colors.grey),
                  onPressed: () => _launchURL(args.account.instagram),
                ),
              ],
            ),
            SizedBox(height: 20),
            TileDetail(
              access: args.account.accessGender,
              name: Languages.gender() + ': ',
              value: args.account.gender.tr(),
              account: args.account,
            ),
            TileDetail(
              access: args.account.accessHeight,
              name: Languages.height() + ': ',
              value: args.account.height.toString(),
              account: args.account,
            ),
            TileDetail(
                access: args.account.accessDateBirth,
                name: Languages.date_birth() + ': ',
                value: DateFormat('yyyy-MM-dd').format(args.account.dateBirth),
                account: args.account),
            Text(Languages.bio() + ': ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(args.account?.bio ?? ''),
            Divider(),
          ],
        ),
      ),
    );
  }
}
