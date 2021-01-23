import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List list;
  final Widget child;
  // final DismissDirectionCallback onDismissed;
  final ValueChanged<String> onDismissed;

  const CustomListView({Key key, @required this.list, @required this.onDismissed, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 75),
          child: Divider(
            height: 5,
            color: Colors.grey,
          )),
      itemCount: list.length,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, int index) {
        final key = list.elementAt(index).id;
        final element = list.elementAt(index);

        return GestureDetector(
          onTap: () {},
          child: Dismissible(
              key: Key(key),
              onDismissed: (direction) {
                // return context.read(providerDatabase).deleteMeasurement(element);
              },
              direction: DismissDirection.startToEnd,
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
              child: Padding(
                padding: const EdgeInsets.only(right: 90),
                child: child,
              )),
        );
      },
    );
  }
}
