import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appwrite/appwrite.dart' as aw;
import 'package:appwrite/models.dart' as awm;
import 'package:fitable/app/auth/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../constants/paths.dart';
import '../../../utilities/services/app_write.dart';
import '../../auth/models/auth_model.dart';
import '../../failure/models/failure_model.dart';
import '../models/account_model.dart';

abstract class BaseAccountRepository {
  Future<void> create({required Auth auth, required String name});
  Future<void> update(Account account);
  Future<Account?> get(Auth auth);
  Stream<Account?> stream(Auth auth);
}

@Singleton()
class AccountRepository extends BaseAccountRepository {
  final AppWrite _appWrite;
  AccountRepository(this._appWrite) : super();

  @override
  Future<void> create({required Auth auth, required String name}) async {
    Future result = _appWrite.database.createDocument(
      collectionId: Paths.accounts(),
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
      collectionId: Paths.accounts(),
      documentId: account.id,
      data: account.toJson(),
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
  Future<Account?> get(Auth auth) async {
    try {
      awm.Document response = await _appWrite.database.getDocument(
        collectionId: Paths.accounts(),
        documentId: auth.userId,
      );

      return await Account(
        name: response.data['name'],
        email: response.data['email'],
        avatar: response.data['avatar'],
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
  Stream<Account?> stream(Auth auth) {
    return _appWrite.realtime.subscribe(['collections.${Paths.accounts()}.documents.${auth.userId}']).stream.cast().map((event) {
          return Account(
            name: event.payload['name'],
            email: event.payload['email'],
            avatar: event.payload['avatar'],
            id: event.payload['\$id'],
          );
        });
  }
}
