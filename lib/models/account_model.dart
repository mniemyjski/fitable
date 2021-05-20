import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AccessLevel { private, coach, friends, public }

class Account {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final double height;
  final DateTime dateBirth;
  final String youtube;
  final String instagram;
  final String facebook;
  final String bio;
  final AccessLevel accessStats;
  final AccessLevel accessMeals;
  final AccessLevel accessMeasurement;
  final AccessLevel accessDateBirth;
  final AccessLevel accessHeight;
  final AccessLevel accessGender;
  final String avatarUrl;
  final List photosUrl;
  final String coach;
  final bool isCoach;
  final bool isDelete;

  Account({
    @required this.uid,
    @required this.name,
    @required this.gender,
    @required this.height,
    @required this.dateBirth,
    @required this.email,
    this.phone = "",
    this.accessStats = AccessLevel.private,
    this.accessMeals = AccessLevel.private,
    this.accessMeasurement = AccessLevel.private,
    this.accessDateBirth = AccessLevel.private,
    this.accessHeight = AccessLevel.private,
    this.accessGender = AccessLevel.private,
    this.bio = "",
    this.youtube = "",
    this.instagram = "",
    this.facebook = "",
    this.avatarUrl = "",
    @required this.photosUrl,
    this.coach = "",
    this.isCoach = false,
    this.isDelete = false,
  });

  Map<String, dynamic> toMap({String uid}) {
    return {
      'uid': uid ?? this.uid,
      'name': name,
      'gender': gender,
      'height': height,
      'dateBirth': dateBirth,
      'accessStats': toText(accessStats),
      'accessMeals': toText(accessMeals),
      'accessMeasurement': toText(accessMeasurement),
      'accessDateBirth': toText(accessDateBirth),
      'accessHeight': toText(accessHeight),
      'accessGender': toText(accessGender),
      'bio': bio,
      'youtube': youtube,
      'instagram': instagram,
      'facebook': facebook,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'photosUrl': photosUrl,
      'coach': coach,
      'isCoach': isCoach,
      'isDelete': isDelete,
    };
  }

  factory Account.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return Account(
      uid: data['uid'],
      name: data['name'],
      gender: data['gender'],
      height: data['height'],
      dateBirth: data['dateBirth'].toDate(),
      accessStats: toEnum(data['accessStats']),
      accessMeals: toEnum(data['accessMeals']),
      accessMeasurement: toEnum(data['accessMeasurement']),
      accessDateBirth: toEnum(data['accessDateBirth']),
      accessHeight: toEnum(data['accessHeight']),
      accessGender: toEnum(data['accessGender']),
      bio: data['bio'],
      youtube: data['youtube'],
      instagram: data['instagram'],
      facebook: data['facebook'],
      email: data['email'],
      phone: data['phone'],
      avatarUrl: data['avatarUrl'],
      photosUrl: data['photosUrl'],
      coach: data['coach'],
      isCoach: data['isCoach'],
      isDelete: data['isDelete'],
    );
  }

  static toText(AccessLevel access) {
    switch (access) {
      case AccessLevel.private:
        return 'private';
        break;
      case AccessLevel.coach:
        return 'coach';
        break;
      case AccessLevel.friends:
        return 'friends';
        break;
      case AccessLevel.public:
        return 'public';
        break;
    }
  }

  static toEnum(String value) {
    switch (value) {
      case 'private':
        return AccessLevel.private;
        break;
      case 'coach':
        return AccessLevel.coach;
        break;
      case 'friends':
        return AccessLevel.friends;
        break;
      case 'public':
        return AccessLevel.public;
        break;
    }
  }

  double age() {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dateBirth.year;
    int month1 = currentDate.month;
    int month2 = dateBirth.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = dateBirth.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.truncateToDouble();
  }
}
