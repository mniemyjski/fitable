import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/product/product_model.dart';

part 'create_product_cubit.freezed.dart';
part 'create_product_cubit.g.dart';
part 'create_product_state.dart';

abstract class BaseCreateProductCubit {
  Future<void> create();
  Future<void> update();
}

class CreateProductCubit extends Cubit<CreateProductState> with BaseCreateProductCubit {
  CreateProductCubit() : super(CreateProductState.initial());

  init({Product? product}) {
    emit(CreateProductState.loading());
    Product product = Product.build(dateCreation: DateTime.now(), dateLastUpdate: DateTime.now());

    emit(CreateProductState.loaded(product));
  }

  @override
  Future<void> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
