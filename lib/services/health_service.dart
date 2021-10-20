import 'package:fitable/models/models.dart';
import 'package:fitable/services/services.dart';
import 'package:fitable/utilities/utilities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

final providerHealthService = Provider<HealthService>((ref) {
  final preference = ref.watch(providerPreference.last);
  final measurement = ref.watch(providerMeasurement.last);
  final measurementService = ref.watch(providerMeasurementService);

  return HealthService(asyncPreference: preference, asyncMeasurements: measurement, measurementService: measurementService);
});

abstract class _BaseHealthService {
  void getHealthData(DateTime dateTime);
  Future<String> getId(DateTime dateTime, ETypeMeasurement eTypeMeasurement);
  List<HealthDataType> getTypesAuthorization();
  Future<bool> checkHealthDataAlreadySync({
    @required DateTime dateTime,
    @required ETypeMeasurement eTypeMeasurement,
    @required double value,
  });
  Future<bool> checkAuthorizationHealth();
}

class HealthService extends _BaseHealthService {
  HealthService({
    @required this.asyncPreference,
    @required this.asyncMeasurements,
    @required this.measurementService,
  })  : assert(asyncPreference != null),
        assert(asyncMeasurements != null),
        assert(measurementService != null);

  final Future<Preference> asyncPreference;
  final Future<List<Measurement>> asyncMeasurements;
  final MeasurementService measurementService;

  @override
  Future<bool> checkHealthDataAlreadySync({
    @required DateTime dateTime,
    @required ETypeMeasurement eTypeMeasurement,
    @required double value,
  }) async {
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    bool _isAlready = false;

    final List<Measurement> measurement = await asyncMeasurements.then((value) => value);

    for (Measurement element in measurement) {
      if (element.dateCreation == dateTime && element.dataType == eTypeMeasurement && element.data.values.first.round() == value.round()) {
        _isAlready = true;
        break;
      }
    }

    if (value == 0 || dateTime.millisecondsSinceEpoch > now.millisecondsSinceEpoch) _isAlready = true;
    return _isAlready;
  }

  @override
  Future<bool> checkAuthorizationHealth() async {
    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) return false;

    HealthFactory health = HealthFactory();
    List<HealthDataType> types = getTypesAuthorization();

    bool accessWasGranted = await health.requestAuthorization(types);
    Logger().i('Service: health_service, Method: checkAuthorizationHealth $accessWasGranted');
    await Permission.activityRecognition.request();
    return accessWasGranted;
  }

  @override
  List<HealthDataType> getTypesAuthorization() {
    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.WEIGHT,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BODY_FAT_PERCENTAGE,
    ];

    return types;
  }

  @override
  Future<String> getId(DateTime dateTime, ETypeMeasurement eTypeMeasurement) async {
    final List<Measurement> measurement = await asyncMeasurements.then((value) => value);

    for (Measurement element in measurement) {
      if (element.dateCreation == dateTime && element.dataType == eTypeMeasurement) return element.id;
    }
    return null;
  }

  @override
  void getHealthData(DateTime dateTime) async {
    final Preference preference = await asyncPreference.then((value) => value);

    if (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS) return;
    if (!preference.healthSync) return;

    Logger().i('Service: health_service, Method: Get Health Data');

    List<HealthDataPoint> _healthDataList = [];

    /// Get everything from midnight until now
    DateTime endDate = dateTime.add(Duration(days: 1));
    DateTime startDate = dateTime.add(Duration(days: 0));

    HealthFactory health = HealthFactory();

    /// Define the types to get.
    List<HealthDataType> types = getTypesAuthorization();

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

    _healthDataList.forEach((x) async {
      if (x.type == HealthDataType.WEIGHT) {
        bool _isAlready = await checkHealthDataAlreadySync(dateTime: x.dateFrom, eTypeMeasurement: ETypeMeasurement.BODY_WEIGHT, value: x.value);

        if (!_isAlready) {
          Map<String, dynamic> _map = new Map();
          _map[Enums.toText(ETypeMeasurement.BODY_WEIGHT)] = x.value;

          Measurement measurement = Measurement(
            source: 'IMPORT',
            dataType: ETypeMeasurement.BODY_WEIGHT,
            data: _map,
            unit: 'kg',
            dateTime: DateTime(x.dateFrom.year, x.dateFrom.month, x.dateFrom.day),
            dateCreation: x.dateFrom,
          );

          measurementService.setMeasurement(measurement: measurement);
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

    bool _isAlready = await checkHealthDataAlreadySync(dateTime: dateTime, eTypeMeasurement: ETypeMeasurement.BURN_CALORIES, value: burn);

    if (!_isAlready) {
      Map<String, dynamic> _map = new Map();
      _map[Enums.toText(ETypeMeasurement.BURN_CALORIES)] = burn;

      String id = await getId(dateTime, ETypeMeasurement.BURN_CALORIES);

      measurementService.setMeasurement(
          measurement: Measurement(
        id: id,
        source: 'IMPORT',
        dataType: ETypeMeasurement.BURN_CALORIES,
        data: _map,
        unit: 'calories',
        dateTime: dateTime,
        dateCreation: dateTime,
      ));
    }

    _isAlready = await checkHealthDataAlreadySync(dateTime: dateTime, eTypeMeasurement: ETypeMeasurement.STEPS, value: steps.roundToDouble());

    if (!_isAlready) {
      Map<String, dynamic> _map = new Map();
      _map[Enums.toText(ETypeMeasurement.STEPS)] = steps;

      String id = await getId(dateTime, ETypeMeasurement.BURN_CALORIES);

      measurementService.setMeasurement(
          measurement: Measurement(
        id: id,
        source: 'IMPORT',
        dataType: ETypeMeasurement.STEPS,
        data: _map,
        unit: 'steps',
        dateTime: dateTime,
        dateCreation: dateTime,
      ));
    }
  }
}
