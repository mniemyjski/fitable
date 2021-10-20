import 'package:equatable/equatable.dart';

abstract class _StatisticModel extends Equatable {}

class StatisticModel extends _StatisticModel {
  StatisticModel({
    this.uid,
    this.year,
    this.bodyFat,
    this.bodyMuscle,
    this.bodyWeight,
    this.burnCalories,
    this.stepsCount,
    this.targetFat,
    this.targetMuscle,
    this.targetWeight,
    this.targetBurnCalories,
    this.targetStepsCount,
    this.eatCalories,
    this.eatProteins,
    this.eatCarbs,
    this.eatFats,
    this.ppmCalories,
    this.ppmProteins,
    this.ppmCarbs,
    this.ppmFats,
  });

  final String uid;
  final String year;

  final double bodyFat;
  final double bodyMuscle;
  final double bodyWeight;
  final int burnCalories;
  final int stepsCount;

  final double targetFat;
  final double targetMuscle;
  final double targetWeight;
  final int targetBurnCalories;
  final int targetStepsCount;

  final int eatCalories;
  final double eatProteins;
  final double eatCarbs;
  final double eatFats;

  final int ppmCalories;
  final double ppmProteins;
  final double ppmCarbs;
  final double ppmFats;

  @override
  // TODO: implement props
  List<Object> get props => [];
}
