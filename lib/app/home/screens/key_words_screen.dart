import 'package:flutter/material.dart';

import '../../../utilities/utilities.dart';

class KeyWordsScreen extends StatefulWidget {
  final List<String> list;
  const KeyWordsScreen({Key? key, required this.list}) : super(key: key);

  @override
  State<KeyWordsScreen> createState() => _KeyWordsScreenState();
}

class _KeyWordsScreenState extends State<KeyWordsScreen> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _list;

  @override
  void initState() {
    _list = List.from(widget.list);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.key_words),
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
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) => setState(() => _list.removeAt(index)),
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${index + 1}: ${_list[index]}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomSheet: _buildAddModule(),
    );
  }

  Builder _buildAddModule() {
    return Builder(builder: (context) {
      return Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  // key: formKey,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: _controller,
                    validator: (v) => null,
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
                    setState(() => _list.add(_controller.text));
                    FocusScope.of(context).unfocus();
                    _controller.text = '';
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
