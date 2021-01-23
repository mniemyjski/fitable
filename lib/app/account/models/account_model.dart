import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AccessLevel { private, coach, friends, public }

final providerAccount = StreamProvider<Account>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamAccount();
});

class Account {
  final String uid;
  final String name;
  final String email;
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

  Account({
    @required this.uid,
    @required this.name,
    @required this.gender,
    @required this.height,
    @required this.dateBirth,
    @required this.accessStats,
    @required this.accessMeals,
    @required this.accessMeasurement,
    @required this.accessDateBirth,
    @required this.accessHeight,
    @required this.accessGender,
    @required this.bio,
    @required this.youtube,
    @required this.instagram,
    @required this.facebook,
    @required this.email,
    @required this.avatarUrl,
    @required this.photosUrl,
    this.coach,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
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
      'avatarUrl': avatarUrl,
      'photosUrl': photosUrl,
      'coach': coach,
    };
  }

  factory Account.fromMap(Map<String, dynamic> data, String documentId) {
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
      avatarUrl: data['avatarUrl'],
      photosUrl: data['photosUrl'],
      coach: data['coach'],
    );
  }

  static toText(AccessLevel access) {
    switch (access) {
      case AccessLevel.private:
        return 'private';
        break;
      case AccessLevel.coach:
        return 'private';
        break;
      case AccessLevel.friends:
        return 'private';
        break;
      case AccessLevel.public:
        return 'private';
        break;
    }
  }

  static toEnum(String value) {
    switch (value) {
      case 'private':
        return AccessLevel.private;
        break;
      case 'private':
        return AccessLevel.private;
        break;
      case 'private':
        return AccessLevel.private;
        break;
      case 'private':
        return AccessLevel.private;
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
