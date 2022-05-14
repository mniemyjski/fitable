part of 'create_product_cubit.dart';

@freezed
class CreateProductState with _$CreateProductState {
  const factory CreateProductState.initial() = Initial;
  const factory CreateProductState.loading() = Loading;
  const factory CreateProductState.loaded(Product product) = Loaded;

  factory CreateProductState.fromJson(Map<String, dynamic> json) =>
      _$CreateProductStateFromJson(json);
}
