import 'dart:async';

import 'package:appwrite/appwrite.dart' as aw;
import 'package:injectable/injectable.dart';
import 'package:universal_io/io.dart';

import '../../../constants/constants.dart';
import '../../../utilities/services/app_write.dart';
import '../../auth/models/auth_model.dart';
import '../../failure/models/failure_model.dart';
import '../../issues/models/issue_model.dart';
import '../models/product/product_model.dart';

abstract class BaseProductRepository {
  Future<void> create({required Auth auth, required Product product});
  Future<void> update({required Auth auth, required Issue issue});
  Future<Product> get(String id);
  Stream<List<Product>> stream(String id);
}

@Singleton()
class ProductRepository extends BaseProductRepository {
  final AppWrite _appWrite;
  ProductRepository(this._appWrite) : super();

  @override
  Future<void> create({required Auth auth, required Product product}) async {
    // Logger().wtf(product.toJson()
    //   ..remove('id')
    //   ..remove('runtimeType')
    //   ..update('portions', (value) => [jsonEncode(value)]));

    Future result = _appWrite.database.createDocument(
      collectionId: Collections.products(),
      documentId: 'unique()',
      data: product.toJson()
        ..remove('id')
        ..remove('runtimeType'),
      // ..update('portions', (value) => [jsonEncode(value)]),
      read: ['role:member'],
      write: ['user:${auth.userId}'],
    );

    try {
      await result;
    } on SocketException catch (_) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<void> update({required Auth auth, required Issue issue}) async {
    Future result = _appWrite.database.createDocument(
      collectionId: Collections.issues(),
      documentId: 'unique()',
      data: issue.toJson(),
      read: ['role:member'],
      write: ['user:${auth.userId}'],
    );

    try {
      await result;
    } on SocketException catch (_) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<Product> get(String id) {
    try {
      // await result;
    } on SocketException catch (_) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
    throw UnimplementedError();
  }

  @override
  Stream<List<Product>> stream(String id) {
    try {
      // await result;
    } on SocketException catch (_) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
    throw UnimplementedError();
  }
}
