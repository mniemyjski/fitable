import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Rating extends Equatable {
  const Rating({
    this.uid,
    this.dateCreation,
    @required this.id,
    @required this.rating,
  });

  final String uid;
  final String id;
  final DateTime dateCreation;
  final double rating;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

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

  Rating copyWith({
    String uid,
    String id,
    DateTime dateCreation,
    double rating,
  }) {
    if ((uid == null || identical(uid, this.uid)) &&
        (id == null || identical(id, this.id)) &&
        (dateCreation == null || identical(dateCreation, this.dateCreation)) &&
        (rating == null || identical(rating, this.rating))) {
      return this;
    }

    return new Rating(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      dateCreation: dateCreation ?? this.dateCreation,
      rating: rating ?? this.rating,
    );
  }
}
