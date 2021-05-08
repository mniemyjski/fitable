import 'package:fitable/app/home/view_models/app_view_model.dart';
import 'package:fitable/app/measurement/models/measurement_model.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerMeasurementViewModel = ChangeNotifierProvider.autoDispose<MeasurementViewModel>((ref) {
  return MeasurementViewModel();
});

class MeasurementViewModel extends ChangeNotifier {
  double _neck;
  double _chest;
  double _biceps;
  double _waist;
  double _abdomen;
  double _hips;
  double _thigh;
  double _calf;
  double _bodyFat;
  bool _calculate;
  double age;
  String gender;

  double get neck => _neck;
  double get chest => _chest;
  double get biceps => _biceps;
  double get waist => _waist;
  double get abdomen => _abdomen;
  double get hips => _hips;
  double get thigh => _thigh;
  double get calf => _calf;
  bool get calculate => _calculate ?? false;

  String get bodyFat {
    double body;

    if (gender == 'male' && (_chest ?? 0.0) > 0.0 && (_neck ?? 0.0) > 0.0 && (_thigh ?? 0.0) > 0.0) {
      double _v = (_chest + _neck + _thigh) / 3;
      body = 1.1093800 - (0.0008267 * _v) + (0.0000016 * (_v * _v)) - (0.0002574 * age);
      _bodyFat = (457 / body) - 414.2;
    }

    if (gender == 'female' && (_biceps ?? 0.0) > 0.0 && (_hips ?? 0.0) > 0.0 && (_thigh ?? 0.0) > 0.0) {
      double _v = (_biceps + _hips + _thigh) / 3;
      body = 1.099421 - (0.0009929 * _v) + (0.0000023 * (_v * _v)) - (0.0001392 * age);
      _bodyFat = (457 / body) - 414.2;
    }

    return _bodyFat != null ? '${_bodyFat.toStringAsFixed(1)}%' : 'error';
  }

  String submitCircumferences(BuildContext context) {
    if (_neck == null) return 'error';
    if (_chest == null) return 'error';
    if (_biceps == null) return 'error';
    if (_waist == null) return 'error';
    if (_abdomen == null) return 'error';
    if (_thigh == null) return 'error';
    if (_calf == null) return 'error';

    final db = context.read(providerDatabase);
    final app = context.read(providerAppViewModel);

    Map<String, dynamic> _map = new Map();
    _map['NECK'] = _neck;
    _map['CHEST'] = _chest;
    _map['BICEPS'] = _biceps;
    _map['WAIST'] = _waist;
    _map['ABDOMEN'] = _abdomen;
    _map['THIGH'] = _thigh;
    _map['CALF'] = _calf;

    Measurement measurement = Measurement(
      source: 'USER',
      dataType: EnumMeasurement.BODY_CIRCUMFERENCES,
      data: _map,
      unit: 'cm',
      dateTime: app.chosenDate,
      dateCreation: DateTime.now(),
    );
    db.setMeasurement(measurement: measurement);

    if (calculate) {
      Map<String, dynamic> _map = new Map();
      _map['BODY_FAT'] = _bodyFat;

      Measurement _m = Measurement(
        source: 'USER',
        dataType: EnumMeasurement.BODY_FAT,
        data: _map,
        unit: '%',
        dateTime: app.chosenDate,
        dateCreation: DateTime.now(),
      );
      db.setMeasurement(measurement: _m);
    }

    Navigator.pop(context);

    return 'done';
  }

  submitMeasurement(BuildContext context, double value, String unit, EnumMeasurement type) {
    final db = context.read(providerDatabase);
    final app = context.read(providerAppViewModel);

    Map<String, dynamic> _map = new Map();
    _map[Measurement.toText(type)] = value;

    Measurement measurement = Measurement(
      source: 'USER',
      dataType: type,
      data: _map,
      unit: unit,
      dateTime: app.chosenDate,
      dateCreation: DateTime.now(),
    );
    db.setMeasurement(measurement: measurement);
    Navigator.pop(context);
  }

  String toText(double value) {
    return value != null ? value.toStringAsFixed(2) + ' cm' : null;
  }

  set neck(double neck) {
    _neck = neck;
    notifyListeners();
  }

  set chest(double chest) {
    _chest = chest;
    notifyListeners();
  }

  set biceps(double biceps) {
    _biceps = biceps;
    notifyListeners();
  }

  set waist(double waist) {
    _waist = waist;
    notifyListeners();
  }

  set abdomen(double abdomen) {
    _abdomen = abdomen;
    notifyListeners();
  }

  set hips(double hips) {
    _hips = hips;
    notifyListeners();
  }

  set thigh(double thigh) {
    _thigh = thigh;
    notifyListeners();
  }

  set calf(double calf) {
    _calf = calf;
    notifyListeners();
  }

  set calculate(bool calculate) {
    _calculate = calculate;
    notifyListeners();
  }
}
