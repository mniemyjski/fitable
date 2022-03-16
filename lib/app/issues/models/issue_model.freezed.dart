// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'issue_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return _Issue.fromJson(json);
}

/// @nodoc
class _$IssueTearOff {
  const _$IssueTearOff();

  _Issue call(
      {required ETypeElement elementType,
      required ETypeIssue issueType,
      required String id,
      required String uid,
      required DateTime dateCreate,
      required String description,
      required dynamic element}) {
    return _Issue(
      elementType: elementType,
      issueType: issueType,
      id: id,
      uid: uid,
      dateCreate: dateCreate,
      description: description,
      element: element,
    );
  }

  Issue fromJson(Map<String, Object?> json) {
    return Issue.fromJson(json);
  }
}

/// @nodoc
const $Issue = _$IssueTearOff();

/// @nodoc
mixin _$Issue {
  ETypeElement get elementType => throw _privateConstructorUsedError;
  ETypeIssue get issueType => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  DateTime get dateCreate => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  dynamic get element => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IssueCopyWith<Issue> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssueCopyWith<$Res> {
  factory $IssueCopyWith(Issue value, $Res Function(Issue) then) =
      _$IssueCopyWithImpl<$Res>;
  $Res call(
      {ETypeElement elementType,
      ETypeIssue issueType,
      String id,
      String uid,
      DateTime dateCreate,
      String description,
      dynamic element});
}

/// @nodoc
class _$IssueCopyWithImpl<$Res> implements $IssueCopyWith<$Res> {
  _$IssueCopyWithImpl(this._value, this._then);

  final Issue _value;
  // ignore: unused_field
  final $Res Function(Issue) _then;

  @override
  $Res call({
    Object? elementType = freezed,
    Object? issueType = freezed,
    Object? id = freezed,
    Object? uid = freezed,
    Object? dateCreate = freezed,
    Object? description = freezed,
    Object? element = freezed,
  }) {
    return _then(_value.copyWith(
      elementType: elementType == freezed
          ? _value.elementType
          : elementType // ignore: cast_nullable_to_non_nullable
              as ETypeElement,
      issueType: issueType == freezed
          ? _value.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as ETypeIssue,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreate: dateCreate == freezed
          ? _value.dateCreate
          : dateCreate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$IssueCopyWith<$Res> implements $IssueCopyWith<$Res> {
  factory _$IssueCopyWith(_Issue value, $Res Function(_Issue) then) =
      __$IssueCopyWithImpl<$Res>;
  @override
  $Res call(
      {ETypeElement elementType,
      ETypeIssue issueType,
      String id,
      String uid,
      DateTime dateCreate,
      String description,
      dynamic element});
}

/// @nodoc
class __$IssueCopyWithImpl<$Res> extends _$IssueCopyWithImpl<$Res>
    implements _$IssueCopyWith<$Res> {
  __$IssueCopyWithImpl(_Issue _value, $Res Function(_Issue) _then)
      : super(_value, (v) => _then(v as _Issue));

  @override
  _Issue get _value => super._value as _Issue;

  @override
  $Res call({
    Object? elementType = freezed,
    Object? issueType = freezed,
    Object? id = freezed,
    Object? uid = freezed,
    Object? dateCreate = freezed,
    Object? description = freezed,
    Object? element = freezed,
  }) {
    return _then(_Issue(
      elementType: elementType == freezed
          ? _value.elementType
          : elementType // ignore: cast_nullable_to_non_nullable
              as ETypeElement,
      issueType: issueType == freezed
          ? _value.issueType
          : issueType // ignore: cast_nullable_to_non_nullable
              as ETypeIssue,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreate: dateCreate == freezed
          ? _value.dateCreate
          : dateCreate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Issue with DiagnosticableTreeMixin implements _Issue {
  const _$_Issue(
      {required this.elementType,
      required this.issueType,
      required this.id,
      required this.uid,
      required this.dateCreate,
      required this.description,
      required this.element});

  factory _$_Issue.fromJson(Map<String, dynamic> json) =>
      _$$_IssueFromJson(json);

  @override
  final ETypeElement elementType;
  @override
  final ETypeIssue issueType;
  @override
  final String id;
  @override
  final String uid;
  @override
  final DateTime dateCreate;
  @override
  final String description;
  @override
  final dynamic element;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Issue(elementType: $elementType, issueType: $issueType, id: $id, uid: $uid, dateCreate: $dateCreate, description: $description, element: $element)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Issue'))
      ..add(DiagnosticsProperty('elementType', elementType))
      ..add(DiagnosticsProperty('issueType', issueType))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('dateCreate', dateCreate))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('element', element));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Issue &&
            const DeepCollectionEquality()
                .equals(other.elementType, elementType) &&
            const DeepCollectionEquality().equals(other.issueType, issueType) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality()
                .equals(other.dateCreate, dateCreate) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.element, element));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(elementType),
      const DeepCollectionEquality().hash(issueType),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(dateCreate),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(element));

  @JsonKey(ignore: true)
  @override
  _$IssueCopyWith<_Issue> get copyWith =>
      __$IssueCopyWithImpl<_Issue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IssueToJson(this);
  }
}

abstract class _Issue implements Issue {
  const factory _Issue(
      {required ETypeElement elementType,
      required ETypeIssue issueType,
      required String id,
      required String uid,
      required DateTime dateCreate,
      required String description,
      required dynamic element}) = _$_Issue;

  factory _Issue.fromJson(Map<String, dynamic> json) = _$_Issue.fromJson;

  @override
  ETypeElement get elementType;
  @override
  ETypeIssue get issueType;
  @override
  String get id;
  @override
  String get uid;
  @override
  DateTime get dateCreate;
  @override
  String get description;
  @override
  dynamic get element;
  @override
  @JsonKey(ignore: true)
  _$IssueCopyWith<_Issue> get copyWith => throw _privateConstructorUsedError;
}
