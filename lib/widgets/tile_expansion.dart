import 'package:flutter/material.dart';

class TileExpansion extends StatelessWidget {
  final Widget head;
  final List list;
  final VoidCallback? onPressed;

  const TileExpansion({Key? key, required this.head, required this.list, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 5, right: 18),
      childrenPadding: EdgeInsets.only(left: 5, right: 90),
      initiallyExpanded: true,
      title: Card(
        margin: EdgeInsets.only(bottom: 5, top: 6),
        child: Container(
          height: 47,
          margin: EdgeInsets.only(left: 5),
          child: head,
        ),
      ),
      children: [
        ListView.separated(
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
            return GestureDetector(
              onTap: () => null,
              child: Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) => null,
                direction: DismissDirection.horizontal,
                background: Container(
                    color: Colors.red[600],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ],
                    )),
                child: list[index],
              ),
            );
          },
        ),
        SizedBox(
          height: 8,
        )
      ],
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      trailing: Card(
        color: Theme.of(context).primaryColor,
        child: Container(
          height: double.infinity,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
