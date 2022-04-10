import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import 'package:fitable/utilities/utilities.dart';
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
                  '${AppLocalizations.of(context)!.comments} (1):',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextButton(onPressed: () => null, child: Text(AppLocalizations.of(context)!.addComment)),
            ],
          ),
          Divider(),
          ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            itemCount: 3,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => CommentWidget(),
          ),
          TextButton(onPressed: () => null, child: Text(AppLocalizations.of(context)!.more)),
        ],
      ),
    );
  }
}
