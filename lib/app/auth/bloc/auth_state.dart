part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial(Auth? auth) = Initial;
  const factory AuthState.authenticated(Auth auth) = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);
}
