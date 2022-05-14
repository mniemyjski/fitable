import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:flutter/material.dart';

DragAndDropItem dragAndDropItem() {
  return DragAndDropItem(
    child: Builder(builder: (context) {
      return Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              'Sub 1',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      );
    }),
  );
}
