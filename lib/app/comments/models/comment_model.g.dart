// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      uid: json['uid'] as String,
      id: json['id'] as String,
      author: json['author'] as String,
      dateCreation: DateTime.parse(json['dateCreation'] as String),
      dateLastEdit: DateTime.parse(json['dateLastEdit'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'id': instance.id,
      'author': instance.author,
      'dateCreation': instance.dateCreation.toIso8601String(),
      'dateLastEdit': instance.dateLastEdit.toIso8601String(),
      'text': instance.text,
    };
