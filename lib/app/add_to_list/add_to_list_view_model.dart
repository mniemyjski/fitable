import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/add_to_list/portion_model.dart';
import 'package:fitable/common_widgets/custom_list_view.dart';
import 'package:fitable/common_widgets/massage_flush_bar.dart';
import 'package:fitable/constants/constants.dart';
import 'package:fitable/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAddToListViewModel = ChangeNotifierProvider.autoDispose<AddToListViewModel>((ref) {
  return AddToListViewModel();
});

class AddToListViewModel extends ChangeNotifier {
  List list;
  EnumTileType tileType;
  String unit;
  String valueListener;
  String _portionListener;

  String get portionListener => _portionListener;

  set portionListener(String portionListener) {
    _portionListener = portionListener;
    notifyListeners();
  }

  TextEditingController controller = TextEditingController(text: '');

  initState(List list, EnumTileType detailsType, String unit) {
    if (this.list == null) {
      this.list = List.from(list);
      this.tileType = detailsType;
      this.unit = unit;
      _reorderList();
    }
  }

  onCheck(BuildContext context) {
    Navigator.pop(context, list);
  }

  onDismissed(dynamic element) {
    list.remove(element);
    _reorderList();
    notifyListeners();
  }

  addToList(BuildContext context) {
    if (tileType == EnumTileType.keyWord) {
      list.add(valueListener);
      controller.text = '';
    }
    if (tileType == EnumTileType.portion) {
      if (_portionListener != null) {
        list.add(new Portion(name: _portionListener, size: int.tryParse(valueListener), unit: Enums.unitTypeToEnum(unit)));
        controller.text = '';
        _portionListener = null;
        _reorderList();
      } else {
        massageFlushBar(context, Constants.portion_cannot_be_empty());
      }
    }
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  _reorderList() {
    if (tileType == EnumTileType.portion) {
      list.removeWhere((element) => element.name == unit);
      List _list = [];
      _list.add(new Portion(name: unit, size: 1, unit: Enums.unitTypeToEnum(unit)));
      _list.addAll(list);
      list = List.from(_list);
      notifyListeners();
    }
  }
}
