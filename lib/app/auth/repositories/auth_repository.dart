import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:fitable/app/auth/models/auth_model.dart';
import 'package:fitable/app/failure/models/failure_model.dart';
import 'package:fitable/utilities/services/app_write.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthRepository {
  final AppWrite _appWrite;
  late Account _account;
  late Database _database;

  AuthRepository(this._appWrite) : super() {
    _account = Account(_appWrite.client);
    _database = Database(_appWrite.client);
  }

  Future<String?> signUpWithEmail(Auth auth) async {
    Future create = _account.create(
      name: auth.email,
      email: auth.email,
      password: auth.password,
    );

    try {
      await create;
      return await signInWithEmail(auth);
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  Future<String?> signInWithEmail(Auth auth) async {
    try {
      return await _account
          .createSession(email: auth.email, password: auth.password)
          .then((value) => value.$id);
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  updatePref() {
    Map map = Map();
    map['test1'] = '1';
    _account.updatePrefs(prefs: map);
  }

  getUser() async {
    try {
      await _account.get();
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  Future<String?> getSessionById(String sessionId) async {
    try {
      final String? id = await _account
          .getSession(sessionId: sessionId)
          .then((value) => value.$id);
      await getUser();
      return id;
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  Future<Either<Failure, String>> signInWithGoogle() async {
    try {
      return right('dsf');
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  deleteAccount() async {
    try {
      await _account.delete();
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  signOut(String sessionId) async {
    try {
      await _account.deleteSession(sessionId: sessionId);
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  signOutAllDevices() async {
    try {
      await _account.deleteSessions();
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }
}
