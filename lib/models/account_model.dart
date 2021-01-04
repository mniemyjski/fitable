import 'package:flutter/material.dart';

enum AccessLevel { private, coach, friends, public }

class User {
  final String uid;
  // final String name;
  // final String email;
  // final String gender;
  // final double height;
  // final DateTime dateBirth;
  // final String youtube;
  // final String instagram;
  // final String facebook;
  // final String bio;
  // final AccessLevel accessStats;
  // final AccessLevel accessMeals;
  // final AccessLevel accessMeasurement;
  // final AccessLevel accessDateBirth;
  // final AccessLevel accessHeight;
  // final AccessLevel accessGender;
  // final String avatarUrl;
  // final List photosUrl;
  // final String coach;

  User({
    @required this.uid,
    // @required this.name,
    // @required this.gender,
    // @required this.height,
    // @required this.dateBirth,
    // @required this.accessStats,
    // @required this.accessMeals,
    // @required this.accessMeasurement,
    // @required this.accessDateBirth,
    // @required this.accessHeight,
    // @required this.accessGender,
    // this.bio,
    // this.youtube,
    // this.instagram,
    // this.facebook,
    // this.email,
    // this.avatarUrl,
    // this.photosUrl,
    // this.coach,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
    };
  }

  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    return User(
      uid: data['uid'],
      // name: data['name'],
      // gender: data['gender'],
      // height: data['height'],
      // dateBirth: data['dateBirth'],
      // accessStats: AccessLevel.private,
      // accessMeals: AccessLevel.private,
      // accessMeasurement: AccessLevel.private,
      // accessDateBirth: AccessLevel.private,
      // accessHeight: AccessLevel.private,
      // accessGender: AccessLevel.private,
    );
  }
}
