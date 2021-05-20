import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/models/portion_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/massage_flush_bar.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAddToListViewModel = ChangeNotifierProvider.autoDispose<AddToListViewModel>((ref) {
  return AddToListViewModel();
});

class AddToListViewModel extends ChangeNotifier {
  List list;
  EnumTileType tileType;
  ETypeUnit unit;
  String sizeListener;
  String _typeListener;

  String get portionListener => _typeListener;

  set portionListener(String portionListener) {
    _typeListener = portionListener;
    notifyListeners();
  }

  TextEditingController controller = TextEditingController(text: '');

  initState(List list, EnumTileType detailsType, ETypeUnit unit) {
    if (this.list == null) {
      this.list = List.from(list);
      this.tileType = detailsType;
      this.unit = unit;
      _reorderList();
    }
  }

  save(BuildContext context) {
    Navigator.pop(context, list);
  }

  onDismissed(dynamic element) {
    list.remove(element);
    _reorderList();
    notifyListeners();
  }

  addSuggested(String name) {
    list.add(name);
    list = LinkedHashSet<String>.from(list).toList();
    notifyListeners();
  }

  addToList(BuildContext context) {
    if (tileType == EnumTileType.keyWord) {
      list.add(sizeListener);
      controller.text = '';
    }
    if (tileType == EnumTileType.portion) {
      if (_typeListener != null) {
        list.add(new Portion(
            name: '${Enums.toText(_typeListener)} $sizeListener${Enums.toText(unit)}',
            type: _typeListener,
            size: double.tryParse(sizeListener),
            unit: unit));
        controller.text = '';
        _typeListener = null;
        _reorderList();
      } else {
        massageFlushBar(context, Languages.portion_cannot_be_empty());
      }
    }
    list = LinkedHashSet<String>.from(list).toList();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  _reorderList() {
    if (tileType == EnumTileType.portion) {
      list.removeWhere((element) => element.type == Enums.toText(unit));
      List _list = [];
      _list.add(
        new Portion(
          name: '${Enums.toText(unit)}',
          type: Enums.toText(unit),
          size: 1,
          unit: unit,
        ),
      );
      _list.addAll(list);
      list = List.from(_list);
    }
  }
}
