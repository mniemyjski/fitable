import 'package:flutter/material.dart';

class TileKeyWord extends StatelessWidget {
  final int index;
  final String element;

  const TileKeyWord({Key key, @required this.index, @required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(8), child: Text('${index + 1}. $element'));
  }
}
