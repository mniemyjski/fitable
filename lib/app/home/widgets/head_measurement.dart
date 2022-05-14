import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utilities/utilities.dart';

class HeadMeasurement extends StatelessWidget {
  const HeadMeasurement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(AppLocalizations.of(context)!.measurement,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.weightScale, color: Colors.grey.withOpacity(0.5), size: 20),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('0',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 8,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    value: 0,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    backgroundColor: Colors.grey[400],
                    strokeWidth: 5,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.bacon, color: Colors.grey.withOpacity(0.5), size: 20),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('0',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: 8,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    value: 0,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    backgroundColor: Colors.grey[400],
                    strokeWidth: 5,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
