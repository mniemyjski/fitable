import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_search_delegate.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<DragAndDropList> _contents = <DragAndDropList>[];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        _contents = List.generate(2, (index) {
          return _dragAndDropList(index);
        });
      });
    });
    super.initState();
  }

  _dragAndDropList(int index) {
    return DragAndDropList(
      header: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: Text(
                  'Header $index',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
      ),
      children: <DragAndDropItem>[
        DragAndDropItem(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  'Sub $index.1',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        DragAndDropItem(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  'Sub $index.2',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        DragAndDropItem(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  'Sub $index.3',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(Strings.favorites()),
            actions: [
              IconButton(
                onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate()),
                icon: FaIcon(Icons.search),
              ),
              IconButton(
                onPressed: () => null,
                icon: FaIcon(FontAwesomeIcons.barcode),
              ),
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: Strings.products(),
                ),
                Tab(
                  text: Strings.recipes(),
                ),
                Tab(
                  text: Strings.your_recipes(),
                ),
              ],
            ),
          ),
          body: DragAndDropLists(
            children: _contents,
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
            onListAdd: _onListAdd,
            listPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemDivider: Divider(
              thickness: 2,
              height: 2,
            ),
            itemDecorationWhileDragging: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            listInnerDecoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            lastItemTargetHeight: 8,
            addLastItemTargetHeightToTop: true,
            lastListTargetSize: 40,
            listDragHandle: DragHandle(
              verticalAlignment: DragHandleVerticalAlignment.top,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
            itemDragHandle: DragHandle(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.menu,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          )),
    );
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  _onListAdd(DragAndDropListInterface newList, int listIndex) {
    print('adding new list');
    setState(() {
      if (listIndex == -1)
        _contents.add(newList as DragAndDropList);
      else
        _contents.insert(listIndex, newList as DragAndDropList);
    });
  }
}
