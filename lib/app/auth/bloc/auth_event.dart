part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheckRequested(String? sessionId) = AuthCheckRequested;
  const factory AuthEvent.signedOut() = SignedOut;
  const factory AuthEvent.deleteAccount() = DeleteAccount;
}
