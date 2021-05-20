import 'package:equatable/equatable.dart';
import 'package:fitable/models/product_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

class Issue extends Equatable {
  const Issue({
    this.uid,
    @required this.issueType,
    @required this.id,
    @required this.dateCreate,
    @required this.description,
    @required this.elementType,
    this.element,
  });

  final ETypeElement elementType;
  final ETypeIssue issueType;
  final String id;
  final String uid;
  final DateTime dateCreate;
  final String description;
  final dynamic element;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  Map<String, dynamic> toMap(String uid) {
    return {
      'elementType': Enums.toText(elementType),
      'issueType': Enums.toText(issueType),
      'id': id,
      'uid': uid,
      'dateCreate': dateCreate,
      'description': description,
      'element': element?.toMap(),
    };
  }

  Issue copyWith({
    ETypeElement elementType,
    ETypeIssue issueType,
    String id,
    String uid,
    DateTime dateCreate,
    String description,
    dynamic element,
  }) {
    if ((elementType == null || identical(elementType, this.elementType)) &&
        (issueType == null || identical(issueType, this.issueType)) &&
        (id == null || identical(id, this.id)) &&
        (uid == null || identical(uid, this.uid)) &&
        (dateCreate == null || identical(dateCreate, this.dateCreate)) &&
        (description == null || identical(description, this.description)) &&
        (element == null || identical(element, this.element))) {
      return this;
    }

    return new Issue(
      elementType: elementType ?? this.elementType,
      issueType: issueType ?? this.issueType,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      dateCreate: dateCreate ?? this.dateCreate,
      description: description ?? this.description,
      element: element ?? this.element,
    );
  }
}
