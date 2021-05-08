import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerPreference = StreamProvider.autoDispose<Preference>((ref) {
  final db = ref.watch(providerDatabase);

  return db.streamPreference();
});

class Preference {
  final String uid;
  final bool healthSync;
  final bool autoPlay;
  final bool mute;
  final bool darkMode;
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

  Preference({
    @required this.uid,
    this.healthSync = false,
    this.autoPlay = false,
    this.mute = false,
    this.darkMode = false,
    this.localeApp = 'pl_PL',
    this.localeBase = 'pl_PL',
    this.formulaBMR = 'standard',
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
    this.targetSteps = 10000,
    this.targetBurnCalories = 2200,
    this.goalCaloriesDefault = true,
    this.goalMacroDefault = true,
    this.goalCalories,
    this.goalProteins = 30.0,
    this.goalCarbs = 50.0,
    this.goalFats = 20.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'healthSync': healthSync,
      'autoPlay': autoPlay,
      'mute': mute,
      'darkMode': darkMode,
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
      darkMode: data['darkMode'],
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
    );
  }
}
