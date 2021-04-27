import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/widgets/tile_account.dart';
import 'package:fitable/app/add_to_list/widgets/tile_key_word.dart';
import 'package:fitable/app/add_to_list/widgets/tile_portion.dart';
import 'package:fitable/app/home/widgets/tile_measurement.dart';
import 'package:fitable/app/meal/widgets/tile_image_recipe.dart';
import 'package:fitable/app/meal/widgets/tile_product.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

enum EnumTileType { ingredient, product, recipe, meal, measurement, imageRecipe, account, keyWord, portion }

class CustomListView extends StatelessWidget {
  final List list;
  final EnumTileType type;
  final DismissDirection direction;
  final ValueChanged<dynamic> onPressed;
  final ValueChanged<dynamic> onDismissed;
  final Axis scrollDirection;

  const CustomListView(
      {Key key,
      @required this.list,
      this.type,
      this.direction = DismissDirection.horizontal,
      this.onPressed,
      this.onDismissed,
      this.scrollDirection = Axis.vertical})
      : super(key: key);

  Widget _buildTile(dynamic element, int index) {
    if (type == EnumTileType.imageRecipe) return TileImageRecipe(recipe: element);
    if (type == EnumTileType.measurement) return TileMeasurement(measurement: element);
    if (type == EnumTileType.account) return TileAccount(element);
    if (type == EnumTileType.keyWord) return TileKeyWord(index: index, element: element);
    if (type == EnumTileType.portion) return TilePortion(index: index, element: element);
    if (type == EnumTileType.meal) return TileProduct(element: element.ingredient, isSuggested: element.isSuggested);
    return TileProduct(element: element);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      separatorBuilder: (context, index) => Container(
        child: Divider(
          height: 5,
          color: Colors.grey,
        ),
      ),
      itemCount: list.length,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, int index) {
        final element = list.elementAt(index);

        final Widget child = _buildTile(element, index);

        if (onDismissed == null) {
          return GestureDetector(
            onTap: () => onPressed(element),
            child: child,
          );
        } else {
          return GestureDetector(
            onTap: () => onPressed(element),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) => onDismissed(element),
              direction: direction,
              background: Container(
                height: double.infinity,
                child: Container(
                    height: double.infinity,
                    color: Colors.red[600],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ],
                    )),
              ),
              child: child,
            ),
          );
        }
      },
    );
  }
}
