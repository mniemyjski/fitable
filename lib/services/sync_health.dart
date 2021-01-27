import 'package:easy_localization/easy_localization.dart';
import 'package:fitable/app/account/models/preference_model.dart';
import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/models/measurement_model.dart';
import 'package:fitable/services/database.dart';
import 'package:fitable/services/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

void authorizationHealth(BuildContext context) {
  if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) return;

  context.read(providerPreference).whenData((preference) async {
    if (preference.healthSync) {
      HealthFactory health = HealthFactory();
      List<HealthDataType> types = _types();

      await health.requestAuthorization(types);
    }
  });
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
  if (preference.healthSync) {
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
            value: _map,
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
    });

    bool _isAlreadyBurnCalories = false;
    bool _isAlreadySteps = false;

    measurement.forEach((element) {
      if (element.dateTime == dateTime && element.dataType == EnumMeasurement.BURN_CALORIES && element.value.values.first == burn) {
        _isAlreadyBurnCalories = true;
      }
      if (element.dateTime == dateTime && element.dataType == EnumMeasurement.STEPS && element.value.values.first == steps) _isAlreadySteps = true;
    });

    if (burn == 0 || dateTime.millisecondsSinceEpoch > now.millisecondsSinceEpoch) _isAlreadyBurnCalories = true;
    if (steps == 0 || dateTime.millisecondsSinceEpoch > now.millisecondsSinceEpoch) _isAlreadySteps = true;

    if (!_isAlreadyBurnCalories) {
      Map<String, dynamic> _map = new Map();
      _map[Measurement.toText(EnumMeasurement.BURN_CALORIES)] = burn;

      Measurement measurement = Measurement(
        source: 'IMPORT',
        dataType: EnumMeasurement.BURN_CALORIES,
        value: _map,
        unit: 'calories',
        dateTime: dateTime,
        dateCreation: dateTime,
      );

      db.setMeasurement(measurement: measurement);
    }
    if (!_isAlreadySteps) {
      Map<String, dynamic> _map = new Map();
      _map[Measurement.toText(EnumMeasurement.STEPS)] = steps;

      Measurement measurement = Measurement(
        source: 'IMPORT',
        dataType: EnumMeasurement.STEPS,
        value: _map,
        unit: 'steps',
        dateTime: dateTime,
        dateCreation: dateTime,
      );

      db.setMeasurement(measurement: measurement);
    }
  } else {
    print("Authorization not granted");
  }
}
