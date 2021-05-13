import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitable/app/account/account_details_screen.dart';
import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/meal/recipe_details_screen.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Card buildTitle(BuildContext context) {
  final RecipeDetailsScreenArguments args = ModalRoute.of(context).settings.arguments;

  if (args.isMeal)
    return Card(
      child: Container(
        height: 60,
        padding: EdgeInsets.all(4.0),
        width: double.infinity,
        child: Center(
          child: AutoSizeText(
            args.element.getName(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
        ),
      ),
    );

  return Card(
    child: Container(
      height: 60,
      padding: EdgeInsets.all(4.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            args.element.getName(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  Account author = await context.read(providerDatabase).getAccount(args.element.recipe.uid);

                  Navigator.of(context).pushNamed(
                    AppRoute.accountDetails,
                    arguments: AccountDetailsScreenArguments(account: author),
                  );
                },
                child: AutoSizeText(
                  args.element.recipe.authorName,
                  style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic, fontSize: 14),
                  maxLines: 1,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: <Widget>[
                      if (args.element.recipe.ratingsCount != 0) ...[
                        FaIcon(FontAwesomeIcons.solidStar),
                        SizedBox(width: 5),
                        Text(args.element.recipe.ratingsAvg.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.solidHeart),
                      SizedBox(width: 5),
                      Text(args.element.recipe.favoritesCount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.solidComments),
                      SizedBox(width: 5),
                      Text(args.element.recipe.commentsCount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}
