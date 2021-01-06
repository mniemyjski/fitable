import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDropDownButton extends StatelessWidget {
  final String name;
  final String value;
  final List<String> list;
  final ValueChanged<String> onChanged;

  const CustomDropDownButton({
    Key key,
    @required this.name,
    @required this.value,
    @required this.list,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 5, bottom: 0, right: 5, top: 10),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 15, top: 5),
              width: double.infinity,
              child: Text(name.tr(), style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold))),
          DropdownButton<String>(
            isDense: true,
            isExpanded: true,
            value: value,
            hint: Text(''),
            underline: Container(
              color: Colors.transparent,
            ),
            onChanged: onChanged,
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      value.tr(),
                      style: TextStyle(fontSize: 14),
                    )),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
