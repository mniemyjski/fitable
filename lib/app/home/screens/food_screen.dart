import 'package:fitable/app/comments/widgets/comments_module.dart';
import 'package:fitable/app/home/widgets/element_meal.dart';
import 'package:fitable/app/home/widgets/nutritional_basic_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class FoodScreen extends StatefulWidget {
  final String title;

  const FoodScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final controllerPage = PageController(keepPage: true);
  late double weight;

  final _pages = List.generate(
      6,
      (index) => Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            child: Container(
              height: 280,
              child: Center(
                  child: Text(
                "Page $index",
                style: TextStyle(color: Colors.indigo),
              )),
            ),
          ));

  @override
  void initState() {
    weight = 100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: FaIcon(FontAwesomeIcons.heart),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: controllerPage,
              itemCount: _pages.length,
              itemBuilder: (_, index) => _pages[index % _pages.length],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: controllerPage,
                count: _pages.length,
                effect: WormEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          _buildTitle(context),
          NutritionalBasicValue(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomButton(
                    onPressed: () {
                      _picker(context);
                    },
                    child: Text('$weight')),
              ),
              Expanded(
                flex: 2,
                child: CustomDropDownButton(
                  name: '',
                  value: 'g',
                  list: ['g', 'Opakowanie'],
                  onChanged: (data) => null,
                ),
              ),
            ],
          ),
          _ingredientsBuild(),
          _descriptionBuild(context),
          _nutritional_value(),
          _buildRating(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Center(child: Text(Strings.report_bug())),
          ),
          CommentsModule(),
          SizedBox(height: 48),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        child: Icon(Icons.add),
      ),
    );
  }

  void _picker(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 999),
          NumberPickerColumn(begin: 0, end: 9),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Text('.'),
          ))
        ],
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          setState(() {
            weight = value[0] + (value[1] / 10);
          });
        }).showDialog(context);
  }

  ExpansionTile _nutritional_value() {
    return ExpansionTile(
      title: Center(
        child: Text(
          Strings.nutritional_value(),
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => Container(
            child: Divider(
              height: 5,
            ),
          ),
          itemCount: 2,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'test',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
          },
        ),
      ],
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      trailing: null,
    );
  }

  Card _descriptionBuild(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Strings.description()}:',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus ac erat ut cursus. Donec tempus lobortis metus sit amet ultricies. Quisque tempus velit in hendrerit gravida. ',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Center(
        child: RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
            size: 32,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
      ),
    );
  }

  Card _buildTitle(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'name',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Text(
                    'author',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () => null,
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    Text(
                      '0',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Icon(Icons.star),
                    Text(
                      '0',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _ingredientsBuild() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${Strings.ingredients()}:',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemCount: 3,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  ElementMeal(style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
    );
  }
}
