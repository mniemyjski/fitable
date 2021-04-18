import 'package:fitable/app/add_details/portion_model.dart';
import 'package:fitable/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TilePortion extends StatelessWidget {
  final int index;
  final Portion element;

  const TilePortion({Key key, @required this.index, @required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(8), child: Text('${index + 1}. ${element.name.tr()}: ${element.size}${Enums.toText(element.unit)}'));
  }
}
