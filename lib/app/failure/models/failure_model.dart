import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure_model.freezed.dart';
part 'failure_model.g.dart';

@freezed
class Failure with _$Failure {
  const factory Failure(
    String? massage,
  ) = _Failure;

  factory Failure.fromJson(Map<String, dynamic> json) => _$FailureFromJson(json);
}
