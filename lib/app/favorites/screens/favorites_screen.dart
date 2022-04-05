import 'package:auto_route/auto_route.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:fitable/app/favorites/widgets/custom_tab_bar.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/constants.dart';
import '../../../widgets/custom_search_delegate.dart';
import '../widgets/drag_and_drop_list.dart';

class FavoritesScreen extends StatefulWidget {
  final ETypeTabBar eTypeTabBar;

  const FavoritesScreen({Key? key, required this.eTypeTabBar}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with TickerProviderStateMixin {
  List<DragAndDropList> _contents = <DragAndDropList>[];
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 3);
    setState(() => _contents = dragAndDropList(list: ['0']));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.favorites()),
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate()),
            icon: FaIcon(Icons.search),
          ),
          IconButton(
            onPressed: () => context.router.push(ProductCreateRoute()),
            icon: FaIcon(FontAwesomeIcons.barcode),
          ),
        ],
        bottom: customTabBar(
            eTypeTabBar: widget.eTypeTabBar,
            controller: _controller,
            onTap: (index) => _changeTab(index)),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.add),
      ),
    );
  }

  void _changeTab(int index) {
    if (index == 0) setState(() => _contents = dragAndDropList(list: ['0']));
    if (index == 1) setState(() => _contents = dragAndDropList(list: ['0', '0']));
    if (index == 2) setState(() => _contents = dragAndDropList(list: ['0', '0', '0']));
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
