import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

import 'drag_and_drop_item.dart';

List<DragAndDropList> dragAndDropList({required List list}) {
  List<DragAndDropList> _contents = <DragAndDropList>[];

  list.forEach((element) {
    DragAndDropList dragAndDropList = DragAndDropList(
      header: Padding(
        padding: EdgeInsets.only(left: 8, bottom: 8),
        child: Builder(builder: (context) {
          return Text(
            'Header',
            style: Theme.of(context).textTheme.bodyText2,
          );
        }),
      ),
      children: <DragAndDropItem>[
        dragAndDropItem(),
        dragAndDropItem(),
        dragAndDropItem(),
      ],
    );

    _contents.add(dragAndDropList);
  });

  return _contents;
}
