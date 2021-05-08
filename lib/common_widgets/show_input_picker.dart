import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

showInputPicker(
    {@required BuildContext context,
    String labelText,
    String title,
    String buttonTextNo,
    String buttonTextYes = 'save',
    String hintText = '',
    String initValue,
    @required VoidCallback onPressed,
    ValueChanged<String> onChanged,
    bool isCancel = false,
    bool isTextField = true,
    bool multiLine = false}) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
              height: 135 + (multiLine ? 120.0 : 0.0) + (title != null ? 25.0 : 0.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (title != null) Text(title, style: TextStyle(fontSize: 16)),
                    if (isTextField)
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
                          hintText: hintText,
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
                              child: CustomButton(
                            child: Text(buttonTextNo != null ? buttonTextNo : Languages.cancel()),
                            color: Colors.indigo,
                            textColor: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          )),
                          SizedBox(width: 10)
                        ],
                        Expanded(
                            child: CustomButton(
                          child: Text(buttonTextYes != null ? buttonTextYes : Languages.save()),
                          color: Colors.indigo,
                          textColor: Colors.white,
                          onPressed: onPressed,
                        ))
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
