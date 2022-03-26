import 'dart:io';

import 'package:appwrite/appwrite.dart' as aw;
import 'package:appwrite/models.dart' as awm;
import 'package:injectable/injectable.dart';

import '../../../utilities/services/app_write.dart';
import '../../failure/models/failure_model.dart';
import '../models/auth_model.dart';

abstract class BaseAuthRepository {
  Future<Auth?> signUpWithEmail({required String email, required String password});
  Future<Auth?> signInWithEmail({required String email, required String password});
  Future<Auth?> getSessionById(String sessionId);
  Future<Auth?> signInWithGoogle();
  Future<void> signOut();
  Future<void> signOutAllDevices();
}

@Singleton()
class AuthRepository extends BaseAuthRepository {
  final AppWrite _appWrite;
  AuthRepository(this._appWrite) : super();

  @override
  Future<Auth?> signUpWithEmail({required String email, required String password}) async {
    Future create = _appWrite.account.create(
      userId: "unique()",
      email: email,
      password: password,
    );

    try {
      await create;
      return await signInWithEmail(email: email, password: password);
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<Auth?> signInWithEmail({required String email, required String password}) async {
    try {
      final session = await _appWrite.account.createSession(email: email, password: password);
      final account = await _appWrite.account.get();
      return Auth(userId: session.userId, sessionId: session.$id, email: account.email);
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<Auth?> getSessionById(String sessionId) async {
    try {
      final awm.Session? session = await _appWrite.account.getSession(sessionId: sessionId);
      final awm.User? account = await _appWrite.account.get();
      if (session != null && account != null) {
        return Auth(userId: session.userId, sessionId: session.$id, email: account.email);
      } else {
        throw Failure('No authentication');
      }
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    } catch (e) {
      throw Failure('No authentication');
    }
  }

  @override
  Future<Auth?> signInWithGoogle() async {
    try {
      return null;
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _appWrite.account.deleteSession(sessionId: 'current');
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }

  @override
  Future<void> signOutAllDevices() async {
    try {
      await _appWrite.account.deleteSessions();
    } on SocketException catch (e) {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      throw Failure(e.message);
    } on aw.AppwriteException catch (e) {
      throw Failure(e.message);
    }
  }
}
