import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement_model.freezed.dart';
part 'measurement_model.g.dart';

enum ETypeMeasurement { BODY_WEIGHT, BODY_FAT, BODY_MUSCLE, BODY_CIRCUMFERENCES, BURN_CALORIES, STEPS }

@freezed
class Measurement with _$Measurement {
  const factory Measurement({
    required String id,
    required String uid,
    required String source,
    required ETypeMeasurement dataType,
    required String unit,
    required DateTime dateTime,
    required DateTime dateCreation,
  }) = _Measurement;

  factory Measurement.fromJson(Map<String, dynamic> json) => _$MeasurementFromJson(json);
}
