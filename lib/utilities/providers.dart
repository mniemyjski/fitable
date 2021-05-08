import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitable/services/auth.dart';
import 'package:fitable/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerAuthBase = Provider<AuthBase>((ref) => Auth());
final providerAuthState = StreamProvider<User>((ref) => ref.watch(providerAuthBase).authStateChanges());
final providerDatabase = Provider<Database>((ref) {
  final auth = ref.watch(providerAuthState);

  if (auth.data?.value?.uid != null) {
    return Database(uid: auth.data?.value?.uid);
  }
  return null;
});
