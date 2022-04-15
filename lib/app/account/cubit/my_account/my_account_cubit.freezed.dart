// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_account_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyAccountState _$MyAccountStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return Initial.fromJson(json);
    case 'unCreated':
      return UnCreated.fromJson(json);
    case 'created':
      return Created.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'MyAccountState',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$MyAccountStateTearOff {
  const _$MyAccountStateTearOff();

  Initial initial() {
    return const Initial();
  }

  UnCreated unCreated() {
    return const UnCreated();
  }

  Created created(Account account) {
    return Created(
      account,
    );
  }

  MyAccountState fromJson(Map<String, Object?> json) {
    return MyAccountState.fromJson(json);
  }
}

/// @nodoc
const $MyAccountState = _$MyAccountStateTearOff();

/// @nodoc
mixin _$MyAccountState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unCreated,
    required TResult Function(Account account) created,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnCreated value) unCreated,
    required TResult Function(Created value) created,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyAccountStateCopyWith<$Res> {
  factory $MyAccountStateCopyWith(
          MyAccountState value, $Res Function(MyAccountState) then) =
      _$MyAccountStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MyAccountStateCopyWithImpl<$Res>
    implements $MyAccountStateCopyWith<$Res> {
  _$MyAccountStateCopyWithImpl(this._value, this._then);

  final MyAccountState _value;
  // ignore: unused_field
  final $Res Function(MyAccountState) _then;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$MyAccountStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

/// @nodoc
@JsonSerializable()
class _$Initial implements Initial {
  const _$Initial({String? $type}) : $type = $type ?? 'initial';

  factory _$Initial.fromJson(Map<String, dynamic> json) =>
      _$$InitialFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MyAccountState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unCreated,
    required TResult Function(Account account) created,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnCreated value) unCreated,
    required TResult Function(Created value) created,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InitialToJson(this);
  }
}

abstract class Initial implements MyAccountState {
  const factory Initial() = _$Initial;

  factory Initial.fromJson(Map<String, dynamic> json) = _$Initial.fromJson;
}

/// @nodoc
abstract class $UnCreatedCopyWith<$Res> {
  factory $UnCreatedCopyWith(UnCreated value, $Res Function(UnCreated) then) =
      _$UnCreatedCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnCreatedCopyWithImpl<$Res> extends _$MyAccountStateCopyWithImpl<$Res>
    implements $UnCreatedCopyWith<$Res> {
  _$UnCreatedCopyWithImpl(UnCreated _value, $Res Function(UnCreated) _then)
      : super(_value, (v) => _then(v as UnCreated));

  @override
  UnCreated get _value => super._value as UnCreated;
}

/// @nodoc
@JsonSerializable()
class _$UnCreated implements UnCreated {
  const _$UnCreated({String? $type}) : $type = $type ?? 'unCreated';

  factory _$UnCreated.fromJson(Map<String, dynamic> json) =>
      _$$UnCreatedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MyAccountState.unCreated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UnCreated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unCreated,
    required TResult Function(Account account) created,
  }) {
    return unCreated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
  }) {
    return unCreated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
    required TResult orElse(),
  }) {
    if (unCreated != null) {
      return unCreated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnCreated value) unCreated,
    required TResult Function(Created value) created,
  }) {
    return unCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
  }) {
    return unCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
    required TResult orElse(),
  }) {
    if (unCreated != null) {
      return unCreated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnCreatedToJson(this);
  }
}

abstract class UnCreated implements MyAccountState {
  const factory UnCreated() = _$UnCreated;

  factory UnCreated.fromJson(Map<String, dynamic> json) = _$UnCreated.fromJson;
}

/// @nodoc
abstract class $CreatedCopyWith<$Res> {
  factory $CreatedCopyWith(Created value, $Res Function(Created) then) =
      _$CreatedCopyWithImpl<$Res>;
  $Res call({Account account});

  $AccountCopyWith<$Res> get account;
}

/// @nodoc
class _$CreatedCopyWithImpl<$Res> extends _$MyAccountStateCopyWithImpl<$Res>
    implements $CreatedCopyWith<$Res> {
  _$CreatedCopyWithImpl(Created _value, $Res Function(Created) _then)
      : super(_value, (v) => _then(v as Created));

  @override
  Created get _value => super._value as Created;

  @override
  $Res call({
    Object? account = freezed,
  }) {
    return _then(Created(
      account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account,
    ));
  }

  @override
  $AccountCopyWith<$Res> get account {
    return $AccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$Created implements Created {
  const _$Created(this.account, {String? $type}) : $type = $type ?? 'created';

  factory _$Created.fromJson(Map<String, dynamic> json) =>
      _$$CreatedFromJson(json);

  @override
  final Account account;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MyAccountState.created(account: $account)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Created &&
            const DeepCollectionEquality().equals(other.account, account));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(account));

  @JsonKey(ignore: true)
  @override
  $CreatedCopyWith<Created> get copyWith =>
      _$CreatedCopyWithImpl<Created>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() unCreated,
    required TResult Function(Account account) created,
  }) {
    return created(account);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
  }) {
    return created?.call(account);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? unCreated,
    TResult Function(Account account)? created,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(account);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(UnCreated value) unCreated,
    required TResult Function(Created value) created,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(UnCreated value)? unCreated,
    TResult Function(Created value)? created,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatedToJson(this);
  }
}

abstract class Created implements MyAccountState {
  const factory Created(Account account) = _$Created;

  factory Created.fromJson(Map<String, dynamic> json) = _$Created.fromJson;

  Account get account;
  @JsonKey(ignore: true)
  $CreatedCopyWith<Created> get copyWith => throw _privateConstructorUsedError;
}
