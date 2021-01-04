import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Stats {
  final String uid;
  final int year;
  final DocumentSnapshot document;
  final Map ppmCalories;
  final Map ppmProteins;
  final Map ppmCarbs;
  final Map ppmFats;
  final Map eatCalories;
  final Map eatProteins;
  final Map eatCarbs;
  final Map eatFats;
  final Map burnCalories;
  final Map countSteps;
  final Map targetSteps;
  final Map targetBurnCalories;
  final Map bodyFat;
  final Map targetBodyFat;
  final Map bodyWeight;
  final Map targetBodyWeight;
  final Map bodyMuscle;

  Stats({
    @required this.uid,
    @required this.year,
    @required this.document,
    @required this.ppmCalories,
    @required this.ppmProteins,
    @required this.ppmCarbs,
    @required this.ppmFats,
    @required this.eatCalories,
    @required this.eatProteins,
    @required this.eatCarbs,
    @required this.eatFats,
    @required this.burnCalories,
    @required this.countSteps,
    @required this.bodyWeight,
    @required this.targetBodyWeight,
    @required this.bodyFat,
    @required this.targetBodyFat,
    @required this.bodyMuscle,
    @required this.targetSteps,
    @required this.targetBurnCalories,
  });

  // factory Stats.fromFirestore({@required DocumentSnapshot document, @required String uid}) {
  //   return Stats(
  //     uid: uid,
  //     year: document.exists ? document.data['year'] : DateTime.now().year,
  //     document: document,
  //     ppmCalories: document.exists ? document.data['ppmCalories'] : Map(),
  //     ppmProteins: document.exists ? document.data['ppmProteins'] : Map(),
  //     ppmCarbs: document.exists ? document.data['ppmCarbs'] : Map(),
  //     ppmFats: document.exists ? document.data['ppmFats'] : Map(),
  //     eatCalories: document.exists ? document.data['eatCalories'] : Map(),
  //     eatProteins: document.exists ? document.data['eatProteins'] : Map(),
  //     eatCarbs: document.exists ? document.data['eatCarbs'] : Map(),
  //     eatFats: document.exists ? document.data['eatFats'] : Map(),
  //     burnCalories: document.exists ? document.data['burnCalories'] : Map(),
  //     countSteps: document.exists ? document.data['countSteps'] : Map(),
  //     targetBodyWeight: document.exists ? document.data['targetBodyWeight'] : Map(),
  //     targetBodyFat: document.exists ? document.data['targetBodyFat'] : Map(),
  //     bodyWeight: document.exists ? document.data['bodyWeight'] : Map(),
  //     bodyFat: document.exists ? document.data['bodyFat'] : Map(),
  //     bodyMuscle: document.exists ? document.data['bodyMuscle'] : Map(),
  //     targetSteps: document.exists ? document.data['targetSteps'] : Map(),
  //     targetBurnCalories: document.exists ? document.data['targetBurnCalories'] : Map(),
  //   );
  // }
}
