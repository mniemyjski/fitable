import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/routes.gr.dart';
import '../../../utilities/enums.dart';
import '../cubit/create_product/create_product_cubit.dart';
import '../models/portions/portion_model.dart';

class Portions extends StatelessWidget {
  const Portions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget>? _portions() {
      return context.watch<CreateProductCubit>().state.whenOrNull(loaded: (product) {
        return product.portions
            .map((e) => Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${e.name}: ${e.size}${Enums.toText(e.unit)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )))
            .toList();
      });
    }

    _onTap() {
      context.read<CreateProductCubit>().state.whenOrNull(
        loaded: (product) async {
          var _list = await context.router.push(PortionsRoute(list: product.portions));
          if (_list != null) {
            context.read<CreateProductCubit>().builder(
                  product.copyWith(portions: _list as List<Portion>),
                );
          }
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Wrap(
              children: _portions() ?? [Container()],
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
                onPressed: () => _onTap(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
