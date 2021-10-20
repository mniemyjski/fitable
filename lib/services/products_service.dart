import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:fitable/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final providerProductsService = Provider<ProductsService>((ref) {
  final auth = ref.watch(providerAuthState).data?.value;
  final storageService = ref.watch(providerStorageService);

  if (auth?.uid != null) {
    return ProductsService(uid: auth?.uid, storageService: storageService);
  }
  return null;
});

abstract class _BaseProductsService {}

class ProductsService {
  ProductsService({@required this.uid, @required this.storageService})
      : assert(uid != null),
        assert(storageService != null);
  final String uid;
  final StorageService storageService;
  final _service = FirebaseFirestore.instance;

  Future<void> createProduct(Product product) {
    Logger().i('create product');
    final DocumentReference ref = _service.collection(Path.products()).doc();
    return ref.set(product.toMap(id: ref.id));
  }

  productNotFound(String barcode) {
    Logger().i('product not found');
    String date = DateFormat('yyyy_MM').format(DateTime.now());
    _service.collection(Path.administration()).doc('not_found_$date').set({barcode: FieldValue.increment(1)}, SetOptions(merge: true));
  }

  Future<bool> productImagesToCreateAlready(String barcode) {
    Logger().i('product image create already');
    return _service.collection(Path.administration()).doc('images_to_create').get().then((value) {
      if (value.exists) return value.data().containsKey(barcode);
      return false;
    });
  }

  productImagesToCreate({@required String barcode, @required List<Uint8List> images}) async {
    Logger().i('product image create');
    List<String> list = [];
    for (Uint8List element in images) {
      String url = await storageService.uploadToFirebaseStorage(
          uint8List: element, folderName: "images_to_create/$barcode", name: images.indexOf(element).toString());
      list.add(url);
    }

    Map map = Map();
    map['done'] = false;
    map['images'] = list;
    return await _service.collection(Path.administration()).doc('images_to_create').set({barcode: map});
  }

  Future<Product> getProduct({String barcode, String id}) {
    Logger().i('get product');
    return _service
        .collection(Path.products())
        .where(barcode != null ? "barcode" : FieldPath.documentId, isEqualTo: barcode != null ? barcode : id)
        .get()
        .then((value) => value.docs.isNotEmpty ? Product.fromMap(value.docs.first.data()) : productNotFound(barcode));
  }
}
