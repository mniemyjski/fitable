import 'package:fitable/app/comments/widgets/comments_module.dart';
import 'package:fitable/app/home/widgets/element_meal.dart';
import 'package:fitable/app/home/widgets/nutritional_value.dart';
import 'package:fitable/widgets/custom_drop_down_button.dart';
import 'package:fitable/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/constants.dart';

class FoodScreen extends StatefulWidget {
  final String title;

  const FoodScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final controllerPage = PageController(viewportFraction: 0.8, keepPage: true);
  final TextEditingController _controllerValue = TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey();

  final _pages = List.generate(
      6,
      (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade300,
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
    _controllerValue.text = '100g';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: controllerPage,
              itemCount: _pages.length,
              itemBuilder: (_, index) {
                return _pages[index % _pages.length];
              },
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
          NutritionalValue(),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                      formKey: _formKey1, controller: _controllerValue, labelText: '')),
              Expanded(
                  child: CustomDropDownButton(
                      name: 'test', list: ['test', 'test'], onChanged: (data) => null)),
            ],
          ),
          _buildRating(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(child: Text(Strings.report_bug())),
          ),
          _ingredientsBuild(),
          // _commentsBuild(context),
          CommentsModule(),
          SizedBox(height: 48),
        ],
      ),
    );
  }

  Padding _buildRating() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
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
            Container(
              height: 3 * 75,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    ElementMeal(style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
