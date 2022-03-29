part of 'my_account_cubit.dart';

@freezed
class MyAccountState with _$MyAccountState {
  const factory MyAccountState.initial() = Initial;
  const factory MyAccountState.unCreated() = UnCreated;
  const factory MyAccountState.created(Account account) = Created;

  factory MyAccountState.fromJson(Map<String, dynamic> json) => _$MyAccountStateFromJson(json);
}
