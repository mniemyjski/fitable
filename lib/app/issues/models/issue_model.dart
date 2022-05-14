import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_model.freezed.dart';
part 'issue_model.g.dart';

enum ETypeElement { product, recipe, account, comment }
enum ETypeIssue { other, correct, regulations }

@freezed
class Issue with _$Issue {
  const factory Issue({
    required ETypeElement elementType,
    required ETypeIssue issueType,
    required String id,
    required String uid,
    required DateTime dateCreate,
    required String description,
    required dynamic element,
  }) = _Issue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}
