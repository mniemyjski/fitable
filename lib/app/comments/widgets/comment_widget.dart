import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              Text(
                'Name',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec maximus ac erat ut cursus. Donec tempus lobortis metus sit amet ultricies. Quisque tempus velit in hendrerit gravida. ',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => null,
                  child: Text(Strings.edit(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: ColorsPalette.url())),
                ),
                GestureDetector(
                  onTap: () => null,
                  child: Text(Strings.delete(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: ColorsPalette.url())),
                ),
                GestureDetector(
                  onTap: () => null,
                  child: Text(Strings.report(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: ColorsPalette.url())),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}