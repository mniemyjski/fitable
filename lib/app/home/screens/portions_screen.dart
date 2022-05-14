import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../models/portions/portion_model.dart';

class PortionsScreen extends StatefulWidget {
  final List<Portion> list;
  const PortionsScreen({Key? key, required this.list}) : super(key: key);

  @override
  State<PortionsScreen> createState() => _PortionsScreenState();
}

class _PortionsScreenState extends State<PortionsScreen> {
  final TextEditingController _controllerSize = TextEditingController();
  final GlobalKey<FormState> _formKeySize = GlobalKey();
  late List<Portion> _list;
  late Portion _portion;
  ETypePortion _type = ETypePortion.package;
  ETypeUnit _unit = ETypeUnit.g;

  @override
  void initState() {
    _list = List.from(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Container _buildAddModule() {
      return Container(
        height: 155,
        padding: EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Container(
              height: 59,
              width: double.infinity,
              padding: EdgeInsets.only(left: 4, right: 4, top: 4),
              child: ElevatedButton(
                onPressed: () {
                  Picker(
                      adapter: PickerDataAdapter<String>(
                        pickerdata: ETypePortion.values.map((e) => Enums.toText(e)).toList()
                          ..removeWhere((e) => e == Enums.toText(ETypePortion.unit)),
                      ),
                      hideHeader: true,
                      selectedTextStyle: TextStyle(color: Colors.blue),
                      onConfirm: (Picker picker, List value) {
                        setState(() => _type =
                            Enums.toEnum(picker.getSelectedValues().first, ETypePortion.values));
                      }).showDialog(context);
                },
                child: Text(
                  Enums.toText(_type),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      // key: formKey,
                      child: Form(
                        key: _formKeySize,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: _controllerSize,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _formKeySize.currentState!.validate(),
                          validator: (v) {
                            if (v == null || v == '') return 'wrong';
                            if (!isFloat(v)) return 'wrong';
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 59,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(bottom: 4, left: 4),
                      ),
                      onPressed: () {
                        Picker(
                            adapter: PickerDataAdapter<String>(
                              pickerdata: ETypeUnit.values.map((e) => Enums.toText(e)).toList(),
                            ),
                            hideHeader: true,
                            selectedTextStyle: TextStyle(color: Colors.blue),
                            onConfirm: (Picker picker, List value) {
                              setState(() => _unit =
                                  Enums.toEnum(picker.getSelectedValues().first, ETypeUnit.values));
                            }).showDialog(context);
                      },
                      child: Text(
                        Enums.toText(_unit),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        if (_formKeySize.currentState!.validate()) {
                          _portion = Portion(
                            name: Enums.toText(_type),
                            type: _type,
                            size: double.parse(_controllerSize.text),
                            unit: _unit,
                          );
                          setState(() => _list.add(_portion));
                          FocusScope.of(context).unfocus();
                          _controllerSize.text = '';
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.portions),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context, _list),
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                final e = _list[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) => setState(() {
                    if (index != 0) _list.removeAt(index);
                  }),
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
                  child: Card(
                      child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Text(
                      '${e.name}: ${e.size}${Enums.toText(e.unit)}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )),
                );
              }),
        ),
        bottomSheet: _buildAddModule(),
      ),
    );
  }
}
