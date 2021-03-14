import 'package:fitable/common_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddKeyWordsScreen extends StatefulWidget {
  final List value;
  const AddKeyWordsScreen(this.value);

  @override
  _AddKeyWordsScreenState createState() => _AddKeyWordsScreenState();
}

class _AddKeyWordsScreenState extends State<AddKeyWordsScreen> {
  TextEditingController controller;
  List _list;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '');
    _list = new List<String>.from(widget.value);
  }

  void submit() {
    FocusScope.of(context).unfocus();

    if (controller.text.length < 4) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text('The name must be longer than 3 characters')));
      return;
    }

    setState(() {
      _list.add(controller.text.toLowerCase());
      controller.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('key_words'.tr()),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, _list);
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
                  itemCount: _list.length,
                  padding: const EdgeInsets.only(top: 2.0),
                  itemBuilder: (context, index) {
                    final element = _list.elementAt(index);

                    return GestureDetector(
                      child: Dismissible(
                          key: Key(element),
                          onDismissed: (direction) {
                            _list.removeAt(index);
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
                              '${index + 1}. $element',
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
                  Expanded(
                    child: Card(
                      child: Container(
                        height: 55,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
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
