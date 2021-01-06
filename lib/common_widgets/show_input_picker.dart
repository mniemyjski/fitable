import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

showInputPicker(
    {@required BuildContext context,
    String labelText,
    String title,
    String buttonTextNo = 'cancel',
    String buttonTextYes = 'save',
    String initValue,
    @required VoidCallback onPressed,
    @required ValueChanged<String> onChanged,
    bool isCancel = false,
    bool multiLine = false}) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
              height: 125 + (multiLine ? 120.0 : 0.0) + (title != null ? 25.0 : 0.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (title != null) Text(title, style: TextStyle(fontSize: 16)),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      initialValue: initValue,
                      autofocus: true,
                      minLines: (multiLine ? 8 : 1),
                      maxLines: (multiLine ? 8 : 1),
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        labelText: labelText?.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        if (isCancel) ...[
                          Expanded(
                            child: RaisedButton(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                child: Center(
                                  child: Text(buttonTextNo.tr(), style: TextStyle(color: Colors.white, fontSize: 20)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10)
                        ],
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            onPressed: onPressed,
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              child: Center(
                                child: Text(buttonTextYes.tr(), style: TextStyle(color: Colors.white, fontSize: 20)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
}
