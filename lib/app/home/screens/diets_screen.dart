import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class DietsScreen extends StatelessWidget {
  const DietsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: Strings.diets()),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(
              Strings.your_diets(),
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              height: 150,
              child: ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                        child: Container(
                          width: 150,
                          height: 150,
                          color: Colors.blue[800],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
