import 'package:fitable/models/product_model.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

class Issue {
  final TypeElement elementType;
  final TypeIssue issueType;
  final String id;
  final String uid;
  final DateTime dateCreate;
  final String description;
  final dynamic element;

  Issue({
    this.uid,
    @required this.issueType,
    @required this.id,
    @required this.dateCreate,
    @required this.description,
    @required this.elementType,
    this.element,
  });

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
}
