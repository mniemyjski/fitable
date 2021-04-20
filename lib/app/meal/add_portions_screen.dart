import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:fitable/common_widgets/custom_drop_down_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddPortionsScreen extends StatefulWidget {
  final Map map;
  final String unit;

  const AddPortionsScreen({Key key, @required this.map, @required this.unit}) : super(key: key);

  @override
  _AddPortionsScreenState createState() => _AddPortionsScreenState();
}

class _AddPortionsScreenState extends State<AddPortionsScreen> {
  TextEditingController controller;
  Map<String, double> _map;
  String _portionChosen;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '');

    _map = new Map<String, double>.from(widget.map);
    if (_map.isEmpty) _map[widget.unit] = 1.0;
  }

  void submit() {
    if (controller.text == "") {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text('Value cannot be empty.')));
      return;
    }

    if (_portionChosen == null) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text('Portion cannot be empty.')));
      return;
    }

    setState(() {
      _map[_portionChosen + ' (${controller.text}${widget.unit})'] = double.parse(controller.text);
      controller.text = '';
      _portionChosen = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('portions'.tr()),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, _map);
              })
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _map.length,
                  padding: const EdgeInsets.only(top: 2.0),
                  itemBuilder: (context, index) {
                    final element = _map.keys.elementAt(index);

                    return GestureDetector(
                      child: Dismissible(
                          key: Key(element),
                          onDismissed: (direction) {
                            _map.remove(_map.keys.elementAt(index));
                          },
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                color: Colors.red[600],
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                )),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text(
                              '${index + 1}. ${element.tr()}',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          )),
                    );
                  }),
            ),
            Container(
              height: 55,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 150,
                    child: CustomDropDownButton(
                      name: 'portion'.tr(),
                      value: _portionChosen,
                      list: <String>['package', 'portion', 'glass', 'teaspoon', 'spoon'],
                      onChanged: (v) {
                        setState(() {
                          _portionChosen = v;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        height: 55,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            border: InputBorder.none,
                            suffix: Text(widget.unit),
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          controller: controller,
                        ),
                      ),
                    ),
                  ),
                  CustomIconButton(onPressed: submit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
