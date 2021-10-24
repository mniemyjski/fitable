// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Issue _$$_IssueFromJson(Map<String, dynamic> json) => _$_Issue(
      elementType: $enumDecode(_$ETypeElementEnumMap, json['elementType']),
      issueType: $enumDecode(_$ETypeIssueEnumMap, json['issueType']),
      id: json['id'] as String,
      uid: json['uid'] as String,
      dateCreate: DateTime.parse(json['dateCreate'] as String),
      description: json['description'] as String,
      element: json['element'],
    );

Map<String, dynamic> _$$_IssueToJson(_$_Issue instance) => <String, dynamic>{
      'elementType': _$ETypeElementEnumMap[instance.elementType],
      'issueType': _$ETypeIssueEnumMap[instance.issueType],
      'id': instance.id,
      'uid': instance.uid,
      'dateCreate': instance.dateCreate.toIso8601String(),
      'description': instance.description,
      'element': instance.element,
    };

const _$ETypeElementEnumMap = {
  ETypeElement.product: 'product',
  ETypeElement.recipe: 'recipe',
  ETypeElement.account: 'account',
  ETypeElement.comment: 'comment',
};

const _$ETypeIssueEnumMap = {
  ETypeIssue.other: 'other',
  ETypeIssue.correct: 'correct',
  ETypeIssue.regulations: 'regulations',
};
