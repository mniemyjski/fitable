import 'package:auto_size_text/auto_size_text.dart';
import 'package:fitable/app/recipe/recipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            args.recipe.name,
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
            args.recipe.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                args.recipe.authorName,
                style: TextStyle(color: Colors.blueAccent, fontStyle: FontStyle.italic, fontSize: 14),
                maxLines: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: <Widget>[
                      if (args.recipe.ratingsCount != 0) ...[
                        FaIcon(FontAwesomeIcons.solidStar),
                        SizedBox(width: 5),
                        Text(args.recipe.ratingsAvg.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.solidHeart),
                      SizedBox(width: 5),
                      Text(args.recipe.favoritesCount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(width: 10),
                      FaIcon(FontAwesomeIcons.solidComments),
                      SizedBox(width: 5),
                      Text(args.recipe.commentsCount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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