import 'package:equatable/equatable.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:flutter/material.dart';

class Account extends Equatable {
  const Account({
    this.uid,
    @required this.name,
    @required this.gender,
    @required this.height,
    @required this.dateBirth,
    @required this.email,
    this.phone = "",
    this.accessStats = ETypeAccess.private,
    this.accessMeals = ETypeAccess.private,
    this.accessMeasurement = ETypeAccess.private,
    this.accessDateBirth = ETypeAccess.private,
    this.accessHeight = ETypeAccess.private,
    this.accessGender = ETypeAccess.private,
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
  final ETypeAccess accessStats;
  final ETypeAccess accessMeals;
  final ETypeAccess accessMeasurement;
  final ETypeAccess accessDateBirth;
  final ETypeAccess accessHeight;
  final ETypeAccess accessGender;
  final String avatarUrl;
  final List photosUrl;
  final String coach;
  final bool isCoach;
  final bool isDelete;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  static const empty = Account(name: null, gender: null, height: null, dateBirth: null, email: null, photosUrl: null);

  Map<String, dynamic> toMap({String uid}) {
    return {
      'uid': uid ?? this.uid,
      'name': name,
      'gender': gender,
      'height': height,
      'dateBirth': dateBirth,
      'accessStats': Enums.toText(accessStats),
      'accessMeals': Enums.toText(accessMeals),
      'accessMeasurement': Enums.toText(accessMeasurement),
      'accessDateBirth': Enums.toText(accessDateBirth),
      'accessHeight': Enums.toText(accessHeight),
      'accessGender': Enums.toText(accessGender),
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
      accessStats: Enums.toEnum(data['accessStats'], ETypeAccess.values),
      accessMeals: Enums.toEnum(data['accessMeals'], ETypeAccess.values),
      accessMeasurement: Enums.toEnum(data['accessMeasurement'], ETypeAccess.values),
      accessDateBirth: Enums.toEnum(data['accessDateBirth'], ETypeAccess.values),
      accessHeight: Enums.toEnum(data['accessHeight'], ETypeAccess.values),
      accessGender: Enums.toEnum(data['accessGender'], ETypeAccess.values),
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

  double getAge() {
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

  Account copyWith({
    String uid,
    String name,
    String email,
    String phone,
    String gender,
    double height,
    DateTime dateBirth,
    String youtube,
    String instagram,
    String facebook,
    String bio,
    ETypeAccess accessStats,
    ETypeAccess accessMeals,
    ETypeAccess accessMeasurement,
    ETypeAccess accessDateBirth,
    ETypeAccess accessHeight,
    ETypeAccess accessGender,
    String avatarUrl,
    List photosUrl,
    String coach,
    bool isCoach,
    bool isDelete,
  }) {
    if ((uid == null || identical(uid, this.uid)) &&
        (name == null || identical(name, this.name)) &&
        (email == null || identical(email, this.email)) &&
        (phone == null || identical(phone, this.phone)) &&
        (gender == null || identical(gender, this.gender)) &&
        (height == null || identical(height, this.height)) &&
        (dateBirth == null || identical(dateBirth, this.dateBirth)) &&
        (youtube == null || identical(youtube, this.youtube)) &&
        (instagram == null || identical(instagram, this.instagram)) &&
        (facebook == null || identical(facebook, this.facebook)) &&
        (bio == null || identical(bio, this.bio)) &&
        (accessStats == null || identical(accessStats, this.accessStats)) &&
        (accessMeals == null || identical(accessMeals, this.accessMeals)) &&
        (accessMeasurement == null || identical(accessMeasurement, this.accessMeasurement)) &&
        (accessDateBirth == null || identical(accessDateBirth, this.accessDateBirth)) &&
        (accessHeight == null || identical(accessHeight, this.accessHeight)) &&
        (accessGender == null || identical(accessGender, this.accessGender)) &&
        (avatarUrl == null || identical(avatarUrl, this.avatarUrl)) &&
        (photosUrl == null || identical(photosUrl, this.photosUrl)) &&
        (coach == null || identical(coach, this.coach)) &&
        (isCoach == null || identical(isCoach, this.isCoach)) &&
        (isDelete == null || identical(isDelete, this.isDelete))) {
      return this;
    }

    return new Account(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      dateBirth: dateBirth ?? this.dateBirth,
      youtube: youtube ?? this.youtube,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      bio: bio ?? this.bio,
      accessStats: accessStats ?? this.accessStats,
      accessMeals: accessMeals ?? this.accessMeals,
      accessMeasurement: accessMeasurement ?? this.accessMeasurement,
      accessDateBirth: accessDateBirth ?? this.accessDateBirth,
      accessHeight: accessHeight ?? this.accessHeight,
      accessGender: accessGender ?? this.accessGender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      photosUrl: photosUrl ?? this.photosUrl,
      coach: coach ?? this.coach,
      isCoach: isCoach ?? this.isCoach,
      isDelete: isDelete ?? this.isDelete,
    );
  }
}
