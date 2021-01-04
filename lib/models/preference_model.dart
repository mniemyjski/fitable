import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  // factory Preference.fromFirestore(DocumentSnapshot document) {
  //   try {
  //     return Preference(
  //       uid: document.documentID,
  //       healthSync: document.data['healthSync'],
  //       autoPlay: document.data['autoPlay'],
  //       mute: document.data['mute'],
  //       localeApp: document.data['localeApp'],
  //       localeBase: document.data['localeBase'],
  //       goalCaloriesDefault: document.data['goalCaloriesDefault'],
  //       goalMacroDefault: document.data['goalMacroDefault'],
  //       goalCalories: document.data['goalCalories'],
  //       goalProteins: document.data['goalProteins'],
  //       goalCarbs: document.data['goalCarbs'],
  //       goalFats: document.data['goalFats'],
  //       formulaBMR: document.data['formulaBMR'],
  //       speedChangeWeight: document.data['speedChangeWeight'],
  //       lastBodyWeightValue: document.data['lastBodyWeightValue'],
  //       lastBodyWeightDate: document.data['lastBodyWeightDate'].toDate(),
  //       lastBodyMuscleValue: document.data['lastBodyMuscleValue'],
  //       lastBodyMuscleDate: document.data['lastBodyMuscleDate'].toDate(),
  //       lastBodyFatValue: document.data['lastBodyFatValue'],
  //       lastBodyFatDate: document.data['lastBodyFatDate'].toDate(),
  //       dayTimeActivities: document.data['dayTimeActivities'],
  //       targetWeight: document.data['targetWeight'],
  //       targetFat: document.data['targetFat'],
  //       targetSteps: document.data['targetSteps'],
  //       targetBurnCalories: document.data['targetBurnCalories'],
  //       products: document.data['products'],
  //       recipes: document.data['recipes'],
  //       exercises: document.data['exercises'],
  //       trainings: document.data['trainings'],
  //     );
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
