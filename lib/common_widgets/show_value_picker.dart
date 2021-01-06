import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

showValuePicker({
  @required context,
  @required int min,
  @required int max,
  @required double initValue,
  @required String unit,
  @required Function function,
  int addition = 1,
  bool isDecimal = true,
}) {
  FixedExtentScrollController firstController;
  FixedExtentScrollController secondController;

  firstController = FixedExtentScrollController(
      initialItem: initValue != null ? ((initValue / addition).floorToDouble().round() - min - 1) : (((max - min) / 2) + min).round());
  secondController = FixedExtentScrollController(initialItem: initValue != null ? ((initValue - initValue.floorToDouble()) / 0.05).round() : 0);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 40,
                                scrollController: firstController,
                                onSelectedItemChanged: (int index) {},
                                children: List<Widget>.generate(max - min, (index) {
                                  return Container(
                                    alignment: isDecimal ? Alignment.centerRight : Alignment.center,
                                    child: Text(
                                      '${(++index + min) * addition}${isDecimal ? ', ' : ' $unit'}',
                                    ),
                                  );
                                }),
                              ),
                            ),
                            if (isDecimal) ...[
                              Expanded(
                                child: CupertinoPicker(
                                  itemExtent: 40,
                                  scrollController: secondController,
                                  onSelectedItemChanged: (int index) {},
                                  children: List<Widget>.generate(20, (int index) {
                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ('${((index * 5) == 0 || (index * 5) == 5 ? 0 : '')}${(++index - 1) * 5} $unit').toString(),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 45,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                          child: Text(
                            'save'.tr(),
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (isDecimal) {
                              function(
                                  (((firstController.selectedItem + min + 1) * addition) + ((secondController.selectedItem * 5) / 100)).toDouble());
                            } else {
                              function(((firstController.selectedItem + min + 1) * addition).toDouble());
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
}
