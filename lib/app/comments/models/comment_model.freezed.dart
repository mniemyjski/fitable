// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
class _$CommentTearOff {
  const _$CommentTearOff();

  _Comment call(
      {required String uid,
      required String id,
      required String author,
      required DateTime dateCreation,
      required DateTime dateLastEdit,
      required String text}) {
    return _Comment(
      uid: uid,
      id: id,
      author: author,
      dateCreation: dateCreation,
      dateLastEdit: dateLastEdit,
      text: text,
    );
  }

  Comment fromJson(Map<String, Object?> json) {
    return Comment.fromJson(json);
  }
}

/// @nodoc
const $Comment = _$CommentTearOff();

/// @nodoc
mixin _$Comment {
  String get uid => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  DateTime get dateCreation => throw _privateConstructorUsedError;
  DateTime get dateLastEdit => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String id,
      String author,
      DateTime dateCreation,
      DateTime dateLastEdit,
      String text});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res> implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  final Comment _value;
  // ignore: unused_field
  final $Res Function(Comment) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? id = freezed,
    Object? author = freezed,
    Object? dateCreation = freezed,
    Object? dateLastEdit = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateLastEdit: dateLastEdit == freezed
          ? _value.dateLastEdit
          : dateLastEdit // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) then) =
      __$CommentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String id,
      String author,
      DateTime dateCreation,
      DateTime dateLastEdit,
      String text});
}

/// @nodoc
class __$CommentCopyWithImpl<$Res> extends _$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(_Comment _value, $Res Function(_Comment) _then)
      : super(_value, (v) => _then(v as _Comment));

  @override
  _Comment get _value => super._value as _Comment;

  @override
  $Res call({
    Object? uid = freezed,
    Object? id = freezed,
    Object? author = freezed,
    Object? dateCreation = freezed,
    Object? dateLastEdit = freezed,
    Object? text = freezed,
  }) {
    return _then(_Comment(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreation: dateCreation == freezed
          ? _value.dateCreation
          : dateCreation // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateLastEdit: dateLastEdit == freezed
          ? _value.dateLastEdit
          : dateLastEdit // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Comment with DiagnosticableTreeMixin implements _Comment {
  const _$_Comment(
      {required this.uid,
      required this.id,
      required this.author,
      required this.dateCreation,
      required this.dateLastEdit,
      required this.text});

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$$_CommentFromJson(json);

  @override
  final String uid;
  @override
  final String id;
  @override
  final String author;
  @override
  final DateTime dateCreation;
  @override
  final DateTime dateLastEdit;
  @override
  final String text;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Comment(uid: $uid, id: $id, author: $author, dateCreation: $dateCreation, dateLastEdit: $dateLastEdit, text: $text)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Comment'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('dateCreation', dateCreation))
      ..add(DiagnosticsProperty('dateLastEdit', dateLastEdit))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Comment &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality()
                .equals(other.dateCreation, dateCreation) &&
            const DeepCollectionEquality()
                .equals(other.dateLastEdit, dateLastEdit) &&
            const DeepCollectionEquality().equals(other.text, text));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(dateCreation),
      const DeepCollectionEquality().hash(dateLastEdit),
      const DeepCollectionEquality().hash(text));

  @JsonKey(ignore: true)
  @override
  _$CommentCopyWith<_Comment> get copyWith =>
      __$CommentCopyWithImpl<_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentToJson(this);
  }
}

abstract class _Comment implements Comment {
  const factory _Comment(
      {required String uid,
      required String id,
      required String author,
      required DateTime dateCreation,
      required DateTime dateLastEdit,
      required String text}) = _$_Comment;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  String get uid;
  @override
  String get id;
  @override
  String get author;
  @override
  DateTime get dateCreation;
  @override
  DateTime get dateLastEdit;
  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$CommentCopyWith<_Comment> get copyWith =>
      throw _privateConstructorUsedError;
}
