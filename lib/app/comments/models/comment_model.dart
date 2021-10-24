import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String uid,
    required String id,
    required String author,
    required DateTime dateCreation,
    required DateTime dateLastEdit,
    required String text,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
