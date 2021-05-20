import 'package:equatable/equatable.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Preference extends Equatable {
  const Preference({
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

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

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

  Preference copyWith({
    String uid,
    bool healthSync,
    bool autoPlay,
    bool mute,
    bool darkMode,
    String localeBase,
    String localeApp,
    String formulaBMR,
    double speedChangeWeight,
    double lastBodyWeightValue,
    DateTime lastBodyWeightDate,
    double lastBodyMuscleValue,
    DateTime lastBodyMuscleDate,
    double lastBodyFatValue,
    DateTime lastBodyFatDate,
    String dayTimeActivities,
    double targetWeight,
    double targetFat,
    double targetSteps,
    double targetBurnCalories,
    bool goalCaloriesDefault,
    bool goalMacroDefault,
    double goalCalories,
    double goalProteins,
    double goalCarbs,
    double goalFats,
  }) {
    if ((uid == null || identical(uid, this.uid)) &&
        (healthSync == null || identical(healthSync, this.healthSync)) &&
        (autoPlay == null || identical(autoPlay, this.autoPlay)) &&
        (mute == null || identical(mute, this.mute)) &&
        (darkMode == null || identical(darkMode, this.darkMode)) &&
        (localeBase == null || identical(localeBase, this.localeBase)) &&
        (localeApp == null || identical(localeApp, this.localeApp)) &&
        (formulaBMR == null || identical(formulaBMR, this.formulaBMR)) &&
        (speedChangeWeight == null || identical(speedChangeWeight, this.speedChangeWeight)) &&
        (lastBodyWeightValue == null || identical(lastBodyWeightValue, this.lastBodyWeightValue)) &&
        (lastBodyWeightDate == null || identical(lastBodyWeightDate, this.lastBodyWeightDate)) &&
        (lastBodyMuscleValue == null || identical(lastBodyMuscleValue, this.lastBodyMuscleValue)) &&
        (lastBodyMuscleDate == null || identical(lastBodyMuscleDate, this.lastBodyMuscleDate)) &&
        (lastBodyFatValue == null || identical(lastBodyFatValue, this.lastBodyFatValue)) &&
        (lastBodyFatDate == null || identical(lastBodyFatDate, this.lastBodyFatDate)) &&
        (dayTimeActivities == null || identical(dayTimeActivities, this.dayTimeActivities)) &&
        (targetWeight == null || identical(targetWeight, this.targetWeight)) &&
        (targetFat == null || identical(targetFat, this.targetFat)) &&
        (targetSteps == null || identical(targetSteps, this.targetSteps)) &&
        (targetBurnCalories == null || identical(targetBurnCalories, this.targetBurnCalories)) &&
        (goalCaloriesDefault == null || identical(goalCaloriesDefault, this.goalCaloriesDefault)) &&
        (goalMacroDefault == null || identical(goalMacroDefault, this.goalMacroDefault)) &&
        (goalCalories == null || identical(goalCalories, this.goalCalories)) &&
        (goalProteins == null || identical(goalProteins, this.goalProteins)) &&
        (goalCarbs == null || identical(goalCarbs, this.goalCarbs)) &&
        (goalFats == null || identical(goalFats, this.goalFats))) {
      return this;
    }

    return new Preference(
      uid: uid ?? this.uid,
      healthSync: healthSync ?? this.healthSync,
      autoPlay: autoPlay ?? this.autoPlay,
      mute: mute ?? this.mute,
      darkMode: darkMode ?? this.darkMode,
      localeBase: localeBase ?? this.localeBase,
      localeApp: localeApp ?? this.localeApp,
      formulaBMR: formulaBMR ?? this.formulaBMR,
      speedChangeWeight: speedChangeWeight ?? this.speedChangeWeight,
      lastBodyWeightValue: lastBodyWeightValue ?? this.lastBodyWeightValue,
      lastBodyWeightDate: lastBodyWeightDate ?? this.lastBodyWeightDate,
      lastBodyMuscleValue: lastBodyMuscleValue ?? this.lastBodyMuscleValue,
      lastBodyMuscleDate: lastBodyMuscleDate ?? this.lastBodyMuscleDate,
      lastBodyFatValue: lastBodyFatValue ?? this.lastBodyFatValue,
      lastBodyFatDate: lastBodyFatDate ?? this.lastBodyFatDate,
      dayTimeActivities: dayTimeActivities ?? this.dayTimeActivities,
      targetWeight: targetWeight ?? this.targetWeight,
      targetFat: targetFat ?? this.targetFat,
      targetSteps: targetSteps ?? this.targetSteps,
      targetBurnCalories: targetBurnCalories ?? this.targetBurnCalories,
      goalCaloriesDefault: goalCaloriesDefault ?? this.goalCaloriesDefault,
      goalMacroDefault: goalMacroDefault ?? this.goalMacroDefault,
      goalCalories: goalCalories ?? this.goalCalories,
      goalProteins: goalProteins ?? this.goalProteins,
      goalCarbs: goalCarbs ?? this.goalCarbs,
      goalFats: goalFats ?? this.goalFats,
    );
  }
}
