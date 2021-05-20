import 'package:flutter/material.dart';

class Rating {
  final String uid;
  final String id;
  final DateTime dateCreation;
  final double rating;

  Rating({
    this.uid,
    this.dateCreation,
    @required this.id,
    @required this.rating,
  });

  Map<String, dynamic> toMap(String uid, String id) {
    return {
      'uid': uid,
      'dateCreation': DateTime.now(),
      'id': id,
      'rating': rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return Rating(
      uid: data['uid'],
      id: data['id'],
      dateCreation: data['dateCreation'].toDate(),
      rating: data['ratting'],
    );
  }
}
