import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerCreateAccountViewModel = ChangeNotifierProvider<CreateAccountViewModel>((ref) => CreateAccountViewModel());

class CreateAccountViewModel extends ChangeNotifier {
  String _name;
  String get name => _name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  DateTime _dateBirth;
  DateTime get dateBirth => _dateBirth;
  set dateBirth(DateTime dateBirth) {
    _dateBirth = dateBirth;
    notifyListeners();
  }

  String _email;
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password;
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String _gender;
  String get gender => _gender;
  set gender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  String _dayTimeActivities;
  String get dayTimeActivities => _dayTimeActivities;
  set dayTimeActivities(String dayTimeActivities) {
    _dayTimeActivities = dayTimeActivities;
    notifyListeners();
  }

  double _height;
  double get height => _height;
  set height(double height) {
    _height = height;
    notifyListeners();
  }

  double _targetWeight;
  double get targetWeight => _targetWeight;
  set targetWeight(double targetWeight) {
    _targetWeight = targetWeight;
    notifyListeners();
  }

  double _targetFat;
  double get targetFat => _targetFat;
  set targetFat(double targetFat) {
    _targetFat = targetFat;
    notifyListeners();
  }

  double _weight;
  double get weight => _weight;
  set weight(double weight) {
    _weight = weight;
    notifyListeners();
  }

  double _fat;
  double get fat => _fat;
  set fat(double fat) {
    _fat = fat;
    notifyListeners();
  }
}
