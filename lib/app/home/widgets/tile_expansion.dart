import 'package:fitable/common_widgets/add_button.dart';
import 'package:flutter/material.dart';

class TileExpansion extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget head;
  final Widget listView;

  const TileExpansion({
    Key key,
    @required this.onPressed,
    @required this.head,
    @required this.listView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 10),
            childrenPadding: EdgeInsets.only(left: 15, right: 80),
            initiallyExpanded: true,
            title: Card(
              margin: EdgeInsets.only(bottom: 5, top: 3),
              child: Container(
                height: 47,
                margin: EdgeInsets.only(left: 5),
                child: head,
              ),
            ),
            trailing: Container(
              height: double.infinity,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: AddButton(onPressed: onPressed),
            ),
            children: <Widget>[
              listView,
            ]));
  }
}
