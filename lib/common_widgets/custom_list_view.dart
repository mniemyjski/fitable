import 'package:fitable/app/home/widgets/tile_measurement.dart';
import 'package:fitable/app/product/widget/tile_product.dart';
import 'package:flutter/material.dart';

enum EnumTileType { product, recipe, meal, measurement }

class CustomListView extends StatelessWidget {
  final List list;
  final EnumTileType type;
  final DismissDirection direction;
  final ValueChanged<dynamic> onPressed;
  final ValueChanged<dynamic> onDismissed;

  const CustomListView({
    Key key,
    @required this.list,
    this.type,
    this.direction = DismissDirection.startToEnd,
    this.onPressed,
    this.onDismissed,
  }) : super(key: key);

  Widget _buildTile(dynamic element) {
    switch (type) {
      case EnumTileType.product:
        return TileProduct(product: element);
      case EnumTileType.meal:
        return TileProduct(meal: element);
      case EnumTileType.measurement:
        return TileMeasurement(measurement: element);
      default:
        return Text(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
        final key = list.elementAt(index).id;
        final Widget child = _buildTile(element);

        return GestureDetector(
          onTap: () => onPressed(element),
          child: Dismissible(
            key: Key(key),
            onDismissed: (direction) => onDismissed(element),
            direction: direction,
            background: Container(
              height: double.infinity,
              child: Container(
                  height: double.infinity,
                  alignment: Alignment.centerLeft,
                  color: Colors.red[600],
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  )),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
