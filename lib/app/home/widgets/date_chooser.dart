import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';

class DateChooser extends StatelessWidget {
  const DateChooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _dateButton(),
        _dateButton(),
        _dateButton(),
      ],
    );
  }

  Builder _dateButton() {
    return Builder(builder: (context) {
      return Expanded(
        child: Center(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                        style: Theme.of(context).textTheme.headline6),
                    Text(Strings.today(), style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
