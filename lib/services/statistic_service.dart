import 'package:fitable/models/models.dart';
import 'package:fitable/services/preference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticService {
  StatisticService({@required this.preference, @required this.account, @required this.preferenceService})
      : assert(preference != null),
        assert(preferenceService != null),
        assert(account != null);

  final AsyncValue<Preference> preference;
  final AsyncValue<Account> account;
  final PreferenceService preferenceService;

  calculateBMR(double weight, double fat) {
    preference.whenData((preference) => account.whenData((account) {
          double age = account.getAge();
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
              preferenceService.updatePreference(name: 'speedChangeWeight', value: 0.0);
            }
            ppm = _fat < preference.targetFat ? ppm + (preference.speedChangeWeight * 400) : ppm - (preference.speedChangeWeight * 400);
          } else if (preference.formulaBMR == 'standard') {
            if (preference.targetWeight.floorToDouble() == preference.lastBodyWeightValue.floorToDouble()) {
              preferenceService.updatePreference(name: 'speedChangeWeight', value: 0.0);
            }
            ppm = _weight < preference.targetWeight ? ppm + (preference.speedChangeWeight * 400) : ppm - (preference.speedChangeWeight * 400);
          }

          // _goalCalories = ppm.round();
          // _goalProteins = ppm * (preference.goalProteins / 100) / 4;
          // _goalCarbs = ppm * (preference.goalCarbs / 100) / 4;
          // _goalFats = ppm * (preference.goalFats / 100) / 9;
        }));
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
}
