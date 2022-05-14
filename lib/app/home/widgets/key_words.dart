import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.gr.dart';
import '../cubit/create_product/create_product_cubit.dart';

class KeyWords extends StatelessWidget {
  const KeyWords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onTapKeywords() {
      context.read<CreateProductCubit>().state.whenOrNull(
        loaded: (product) async {
          var _list = await context.router.push(KeyWordsRoute(list: product.keyWords));

          if (_list != null)
            context.read<CreateProductCubit>().builder(
                  product.copyWith(keyWords: _list as List<String>),
                );
        },
      );
    }

    List<Widget>? _keyWordsText() {
      return context.watch<CreateProductCubit>().state.whenOrNull(loaded: (product) {
        return product.keyWords
            .map((e) => Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )))
            .toList();
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              children: _keyWordsText() ?? [Container()],
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
                onPressed: () => _onTapKeywords(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
