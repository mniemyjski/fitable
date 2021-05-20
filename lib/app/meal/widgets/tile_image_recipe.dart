import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitable/models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TileImageRecipe extends StatelessWidget {
  final Recipe recipe;

  const TileImageRecipe({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imageURL = recipe.photosUrl.isNotEmpty ? recipe.photosUrl[0] : '';

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(2),
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: _imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: CircularProgressIndicator(value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => Icon(Icons.fastfood, size: 80, color: Colors.white),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  ),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(2),
                      child: AutoSizeText(recipe.name, maxLines: 1, minFontSize: 8, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 25,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.solidStar, size: 8),
                        SizedBox(width: 2),
                        Text(recipe.ratingsAvg.toStringAsFixed(1), style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 25,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(5)),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.solidHeart, size: 8),
                        SizedBox(width: 2),
                        Text(recipe.favoritesCount.toStringAsFixed(0), style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
