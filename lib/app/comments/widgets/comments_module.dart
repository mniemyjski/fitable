import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import 'comment_widget.dart';

class CommentsModule extends StatelessWidget {
  const CommentsModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8),
                child: Text(
                  '${Strings.comments()} (1):',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextButton(onPressed: () => null, child: Text(Strings.add_comment())),
            ],
          ),
          Container(
            height: 2 * 135,
            child: ListView(
              children: [
                CommentWidget(),
                CommentWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
