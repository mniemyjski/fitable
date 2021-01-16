import 'package:fitable/app/account/models/account_model.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/product/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerHomeViewModel = ChangeNotifierProvider.autoDispose<HomeViewModel>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends ChangeNotifier {
  int _calories;
  double _proteins;
  double _carbs;
  double _fats;
  int _goalCalories;
  double _goalProteins;
  double _goalCarbs;
  double _goalFats;

  double get goalProteins => _goalProteins;
  double get goalCarbs => _goalCarbs;
  int get goalCalories => _goalCalories;
  double get goalFats => _goalFats;
  int get calories => _calories;
  double get proteins => _proteins;
  double get carbs => _carbs;
  double get fats => _fats;

  bool darkMode = false;
  Color colorPrimary = Colors.lightBlue[700];
  Color colorSecondary = Colors.lightGreen[700];
  Color colorCards = Colors.white;
  Color colorBackground = Colors.grey[200];

  DateTime _chosenDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime get chosenDate => _chosenDate;

  set mealList(List<Meal> mealList) {
    _calories = 0;
    _proteins = 0.0;
    _carbs = 0.0;
    _fats = 0.0;

    mealList.forEach((element) {
      _calories = _calories + (element.product.calories * element.portionSize * element.product.portions[element.portionChosen] / 100).round();
      _proteins = _proteins + (element.product.proteins * element.portionSize * element.product.portions[element.portionChosen] / 100);
      _carbs = _carbs + (element.product.carbs * element.portionSize * element.product.portions[element.portionChosen] / 100);
      _fats = _fats + (element.product.fats * element.portionSize * element.product.portions[element.portionChosen] / 100);
    });
  }

  void chosenDateSet(DateTime value) {
    _chosenDate = DateTime(value.year, value.month, value.day);
    notifyListeners();
  }

  void chosenDateIncrementDecrement(int value) {
    DateTime _v = _chosenDate.add(new Duration(days: value));
    _chosenDate = DateTime(_v.year, _v.month, _v.day);
    notifyListeners();
  }

  void darkModeSet(bool value) {
    darkMode = value;
    if (value) {
    } else {}
    notifyListeners();
  }

  calculateBMR({@required BuildContext context, double weight, double fat}) {
    final preference = context.read(providerPreference).data.value;
    final account = context.read(providerAccount).data.value;

    double age = _calculateAge(account.dateBirth);
    double activities = _activities(preference.dayTimeActivities);
    double _weight = weight == null ? preference.lastBodyWeightValue : weight;
    double _fat = fat == null ? preference.lastBodyFatValue : fat;
    double ppm;

    if (preference.formulaBMR == 'advanced') {
      ppm = (370 + 21.6 * (_weight * (1 - _fat / 100))) * activities;
    } else {
      ppm = ((10 * _weight) + (6.25 * account.height) - (5 * age) + (account.gender == 'male' ? 5 : -161)) * activities;
    }

    if (preference.formulaBMR == 'advanced') {
      if (preference.targetFat.floorToDouble() == preference.lastBodyFatValue.floorToDouble()) {
        // DatabaseService().updatePreference(context: context, uid: preference.uid, key: 'speedChangeWeight', value: 0.0);
      }
      ppm = _fat < preference.targetFat ? ppm + (preference.speedChangeWeight * 400) : ppm - (preference.speedChangeWeight * 400);
    } else if (preference.formulaBMR == 'standard') {
      if (preference.targetWeight.floorToDouble() == preference.lastBodyWeightValue.floorToDouble()) {
        // DatabaseService().updatePreference(context: context, uid: preference.uid, key: 'speedChangeWeight', value: 0.0);
      }
      ppm = _weight < preference.targetWeight ? ppm + (preference.speedChangeWeight * 400) : ppm - (preference.speedChangeWeight * 400);
    }

    _goalCalories = ppm.round();
    _goalProteins = ppm * (preference.goalProteins / 100) / 4;
    _goalCarbs = ppm * (preference.goalCarbs / 100) / 4;
    _goalFats = ppm * (preference.goalFats / 100) / 9;
  }

  static double _activities(String value) {
    switch (value) {
      case 'very_low':
        return 1.2;
      case 'low':
        return 1.3;
      case 'normal':
        return 1.5;
      case 'medium':
        return 1.75;
      case 'high':
        return 2.0;
      default:
        return null;
    }
  }

  static double _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.truncateToDouble();
  }

  String dateName(DateTime chosenDate) {
    DateTime dateTimeNow;

    chosenDate = DateTime(chosenDate.year, chosenDate.month, chosenDate.day);
    dateTimeNow = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (chosenDate == dateTimeNow) {
      return 'today';
    } else if (chosenDate == dateTimeNow.add(new Duration(days: 1))) {
      return 'tomorrow';
    } else if (chosenDate == dateTimeNow.add(new Duration(days: -1))) {
      return 'yesterday';
    } else if (chosenDate.weekday == 1) {
      return 'monday';
    } else if (chosenDate.weekday == 2) {
      return 'tuesday';
    } else if (chosenDate.weekday == 3) {
      return 'wednesday';
    } else if (chosenDate.weekday == 4) {
      return 'thursday';
    } else if (chosenDate.weekday == 5) {
      return 'friday';
    } else if (chosenDate.weekday == 6) {
      return 'saturday';
    } else if (chosenDate.weekday == 7) {
      return 'sunday';
    } else {
      return '';
    }
  }
}
