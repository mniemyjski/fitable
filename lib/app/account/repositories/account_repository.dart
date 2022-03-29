import 'dart:async';

import 'package:appwrite/appwrite.dart' as aw;
import 'package:appwrite/models.dart' as awm;
import 'package:fitable/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:universal_io/io.dart';

import '../../../utilities/services/app_write.dart';
import '../../auth/models/auth_model.dart';
import '../../failure/models/failure_model.dart';
import '../models/account_model.dart';

abstract class BaseAccountRepository {
  Future<void> create({required Auth auth, required String name});
  Future<void> update(Account account);
  Future<Account?> get(String id);
  Stream<Account?> stream(String id);
}

@Singleton()
class AccountRepository extends BaseAccountRepository {
  final AppWrite _appWrite;
  AccountRepository(this._appWrite) : super();

  @override
  Future<void> create({required Auth auth, required String name}) async {
    Future result = _appWrite.database.createDocument(
      collectionId: Collections.accounts(),
      documentId: auth.userId,
      data: Account(name: name, email: auth.email, id: auth.userId).toJson()..remove('id'),
      read: ['role:member'],
      write: ['user:${auth.userId}'],
    );

    try {
      await result;
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<void> update(Account account) async {
    Future result = _appWrite.database.updateDocument(
      collectionId: Collections.accounts(),
      documentId: account.id,
      data: account.toJson()..remove('id'),
    );

    try {
      await result;
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<Account?> get(String id) async {
    try {
      awm.Document response = await _appWrite.database.getDocument(
        collectionId: Collections.accounts(),
        documentId: id,
      );

      return await Account(
        name: response.data['name'],
        email: response.data['email'],
        id: response.$id,
      );
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Stream<Account?> stream(String id) {
    return _appWrite.realtime
        .subscribe(['collections.${Collections.accounts()}.documents.$id'])
        .stream
        .cast()
        .map((event) {
          return Account(
            name: event.payload['name'],
            email: event.payload['email'],
            id: event.payload['\$id'],
          );
        });
  }
}
