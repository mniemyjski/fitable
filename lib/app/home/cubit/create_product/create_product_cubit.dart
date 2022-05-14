import 'package:bloc/bloc.dart';
import 'package:fitable/app/home/models/portions/portion_model.dart';
import 'package:fitable/app/home/repositories/product_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../../models/product/product_model.dart';

part 'create_product_cubit.freezed.dart';
part 'create_product_cubit.g.dart';
part 'create_product_state.dart';

abstract class BaseCreateProductCubit {
  Future<void> create();
  Future<void> update();
  builder(Product product);
}

class CreateProductCubit extends Cubit<CreateProductState> with BaseCreateProductCubit {
  final ProductRepository _productRepository;
  final AuthBloc _authBloc;

  CreateProductCubit({required productRepository, required authBloc})
      : _productRepository = productRepository,
        _authBloc = authBloc,
        super(CreateProductState.initial());

  init({Product? product, required String? barcode}) {
    emit(CreateProductState.loading());

    if (product != null) {
      emit(CreateProductState.loaded(product));
    } else {
      Product product = Product.buildEmpty(
        barcode: barcode ?? '',
        dateCreation: DateTime.now(),
        dateLastUpdate: DateTime.now(),
        withBarcode: barcode != null ? true : false,
        portions: [
          Portion(name: '100g', type: ETypePortion.unit, size: 100, unit: ETypeUnit.g),
        ],
      );
      emit(CreateProductState.loaded(product));
    }
  }

  @override
  Future<void> create() async {
    await state.whenOrNull(
        loaded: (product) async => await _authBloc.state.maybeWhen(
            orElse: () => null,
            authenticated: (auth) => _productRepository.create(auth: auth, product: product)));
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  builder(Product product) {
    emit(CreateProductState.loaded(product));
  }
}
