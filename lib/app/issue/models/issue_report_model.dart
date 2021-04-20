import 'package:fitable/app/meal/models/product_model.dart';
import 'package:flutter/material.dart';

enum EnumIssue { product, recipe, user, comment }

class Issue {
  final EnumIssue type;
  final String id;
  final String uid;
  final DateTime dateCreate;
  final String description;
  final Product product;
  // final Recipe recipe;
  // final User user;
  // final Comment comment;

  Issue({
    this.uid,
    @required this.type,
    @required this.id,
    @required this.dateCreate,
    @required this.description,
    this.product,
  });

  Map<String, dynamic> toMap(String uid) {
    return {
      'type': toText(type),
      'id': id,
      'uid': uid,
      'dateCreate': dateCreate,
      'description': description,
      'product': product?.toMap(),
    };
  }

  static String toText(EnumIssue issuesReport) => issuesReport.toString().split('.').last;
}
