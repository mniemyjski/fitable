import 'package:fitable/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerPreference = StreamProvider.autoDispose<Preference>((ref) {
  final db = ref.watch(providerDatabase);

  return db.preferenceStream();
});

class Preference {
  final String uid;
  final bool healthSync;
  final bool autoPlay;
  final bool mute;
  final String localeBase;
  final String localeApp;
  final String formulaBMR;
  final double speedChangeWeight;
  final double lastBodyWeightValue;
  final DateTime lastBodyWeightDate;
  final double lastBodyMuscleValue;
  final DateTime lastBodyMuscleDate;
  final double lastBodyFatValue;
  final DateTime lastBodyFatDate;
  final String dayTimeActivities;
  final double targetWeight;
  final double targetFat;
  final double targetSteps;
  final double targetBurnCalories;
  final bool goalCaloriesDefault;
  final bool goalMacroDefault;
  final double goalCalories;
  final double goalProteins;
  final double goalCarbs;
  final double goalFats;
  final List products;
  final List recipes;
  final List exercises;
  final List trainings;

  Preference({
    @required this.uid,
    @required this.healthSync,
    @required this.autoPlay,
    @required this.mute,
    @required this.localeApp,
    @required this.localeBase,
    @required this.formulaBMR,
    @required this.speedChangeWeight,
    @required this.lastBodyWeightValue,
    @required this.lastBodyWeightDate,
    @required this.lastBodyMuscleValue,
    @required this.lastBodyMuscleDate,
    @required this.lastBodyFatValue,
    @required this.lastBodyFatDate,
    @required this.dayTimeActivities,
    @required this.targetWeight,
    @required this.targetFat,
    @required this.targetSteps,
    @required this.targetBurnCalories,
    @required this.goalCaloriesDefault,
    @required this.goalMacroDefault,
    @required this.goalCalories,
    @required this.goalProteins,
    @required this.goalCarbs,
    @required this.goalFats,
    @required this.products,
    @required this.recipes,
    @required this.exercises,
    @required this.trainings,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'healthSync': healthSync,
      'autoPlay': autoPlay,
      'mute': mute,
      'localeApp': localeApp,
      'localeBase': localeBase,
      'formulaBMR': formulaBMR,
      'speedChangeWeight': speedChangeWeight,
      'lastBodyWeightValue': lastBodyWeightValue,
      'lastBodyWeightDate': lastBodyWeightDate,
      'lastBodyMuscleValue': lastBodyMuscleValue,
      'lastBodyMuscleDate': lastBodyMuscleDate,
      'lastBodyFatValue': lastBodyFatValue,
      'lastBodyFatDate': lastBodyFatDate,
      'dayTimeActivities': dayTimeActivities,
      'targetWeight': targetWeight,
      'targetFat': targetFat,
      'targetSteps': targetSteps,
      'targetBurnCalories': targetBurnCalories,
      'goalCaloriesDefault': goalCaloriesDefault,
      'goalMacroDefault': goalMacroDefault,
      'goalCalories': goalCalories,
      'goalProteins': goalProteins,
      'goalCarbs': goalCarbs,
      'goalFats': goalFats,
      'products': products,
      'recipes': recipes,
      'exercises': exercises,
      'trainings': trainings,
    };
  }

  factory Preference.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }

    return Preference(
      uid: data['uid'],
      healthSync: data['healthSync'],
      autoPlay: data['autoPlay'],
      mute: data['mute'],
      localeApp: data['localeApp'],
      localeBase: data['localeBase'],
      formulaBMR: data['formulaBMR'],
      speedChangeWeight: data['speedChangeWeight'],
      lastBodyWeightValue: data['lastBodyWeightValue'],
      lastBodyWeightDate: data['lastBodyWeightDate'].toDate(),
      lastBodyMuscleValue: data['lastBodyMuscleValue'],
      lastBodyMuscleDate: data['lastBodyMuscleDate'].toDate(),
      lastBodyFatValue: data['lastBodyFatValue'],
      lastBodyFatDate: data['lastBodyFatDate'].toDate(),
      dayTimeActivities: data['dayTimeActivities'],
      targetWeight: data['targetWeight'],
      targetFat: data['targetFat'],
      targetSteps: data['targetSteps'],
      targetBurnCalories: data['targetBurnCalories'],
      goalCaloriesDefault: data['goalCaloriesDefault'],
      goalMacroDefault: data['goalMacroDefault'],
      goalCalories: data['goalCalories'],
      goalProteins: data['goalProteins'],
      goalCarbs: data['goalCarbs'],
      goalFats: data['goalFats'],
      products: data['products'],
      recipes: data['recipes'],
      exercises: data['exercises'],
      trainings: data['trainings'],
    );
  }
}
