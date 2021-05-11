import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/measurement/models/measurement_model.dart';
import 'package:fitable/services/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

enum AppState { DATA_NOT_FETCHED, FETCHING_DATA, DATA_READY, NO_DATA, AUTH_NOT_GRANTED }

List<HealthDataType> _types() {
  List<HealthDataType> types = [
    HealthDataType.STEPS,
    HealthDataType.WEIGHT,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.BODY_FAT_PERCENTAGE,
  ];

  return types;
}

void authorizationHealth() async {
  if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) return;

  HealthFactory health = HealthFactory();
  List<HealthDataType> types = _types();

  await health.requestAuthorization(types);
}

void syncHealth(DateTime dateTime, Preference preference, List<Measurement> measurement, Database db) async {
  if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) return;
  List<HealthDataPoint> _healthDataList = [];

  /// Get everything from midnight until now
  DateTime endDate = dateTime.add(Duration(days: 1));
  DateTime startDate = dateTime.add(Duration(days: 0));

  DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  HealthFactory health = HealthFactory();

  /// Define the types to get.
  List<HealthDataType> types = _types();

  // bool accessWasGranted = await health.requestAuthorization(types);
  var status = await Permission.activityRecognition.request();

  if (preference.healthSync) {
    // if (accessWasGranted && preference.healthSync) {
    try {
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(startDate, endDate, types);
      _healthDataList.addAll(healthData);
    } catch (e) {
      print("Caught exception in getHealthDataFromTypes: $e");
    }

    /// Filter out duplicates
    _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
    int steps = 0;
    double burn = 0.0;

    /// Print the results
    _healthDataList.forEach((x) {
      if (x.type == HealthDataType.WEIGHT) {
        bool _isAlready = false;

        measurement.forEach((element) {
          if (element.dateCreation == x.dateFrom) _isAlready = true;
        });

        if (!_isAlready) {
          Map<String, dynamic> _map = new Map();
          _map[Measurement.toText(EnumMeasurement.BODY_WEIGHT)] = x.value;

          Measurement measurement = Measurement(
            source: 'IMPORT',
            dataType: EnumMeasurement.BODY_WEIGHT,
            data: _map,
            unit: 'kg',
            dateTime: DateTime(x.dateFrom.year, x.dateFrom.month, x.dateFrom.day),
            dateCreation: x.dateFrom,
          );

          db.setMeasurement(measurement: measurement);
        }
      }
      if (x.type == HealthDataType.STEPS) {
        steps += (x.value as int);
      }
      if (x.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
        burn += (x.value as double);
      }
      if (x.type == HealthDataType.BODY_FAT_PERCENTAGE) {}
    });

    // printError("Steps: $steps");
    // printError("Burn: $burn");

    bool _isAlreadyBurnCalories = false;
    bool _isAlreadySteps = false;
    String burnId;
    String stepsId;

    measurement.forEach((element) {
      if (element.dateTime == dateTime && element.dataType == EnumMeasurement.BURN_CALORIES) burnId = element.id;
      if (element.dateTime == dateTime && element.dataType == EnumMeasurement.STEPS) stepsId = element.id;
      if (element.dateTime == dateTime && element.dataType == EnumMeasurement.BURN_CALORIES && element.data.values.first == burn) {
        _isAlreadyBurnCalories = true;
      }
      if (element.dateTime == dateTime && element.dataType == EnumMeasurement.STEPS && element.data.values.first == steps) _isAlreadySteps = true;
    });

    if (burn == 0 || dateTime.millisecondsSinceEpoch > now.millisecondsSinceEpoch) _isAlreadyBurnCalories = true;
    if (steps == 0 || dateTime.millisecondsSinceEpoch > now.millisecondsSinceEpoch) _isAlreadySteps = true;

    if (!_isAlreadyBurnCalories) {
      Map<String, dynamic> _map = new Map();
      _map[Measurement.toText(EnumMeasurement.BURN_CALORIES)] = burn;

      Measurement value = Measurement(
        id: burnId,
        source: 'IMPORT',
        dataType: EnumMeasurement.BURN_CALORIES,
        data: _map,
        unit: 'calories',
        dateTime: dateTime,
        dateCreation: dateTime,
      );

      db.setMeasurement(measurement: value);
    }
    if (!_isAlreadySteps) {
      Map<String, dynamic> _map = new Map();
      _map[Measurement.toText(EnumMeasurement.STEPS)] = steps;

      Measurement value = Measurement(
        id: stepsId,
        source: 'IMPORT',
        dataType: EnumMeasurement.STEPS,
        data: _map,
        unit: 'steps',
        dateTime: dateTime,
        dateCreation: dateTime,
      );

      db.setMeasurement(measurement: value);
    }
  } else {
    print("Authorization not granted");
  }
}
