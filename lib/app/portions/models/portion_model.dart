import 'package:freezed_annotation/freezed_annotation.dart';

part 'portion_model.freezed.dart';
part 'portion_model.g.dart';

enum ETypeUnit { kg, g, l, ml }

@freezed
class Portion with _$Portion {
  const factory Portion({
    required String name,
    required String type,
    required double size,
    required ETypeUnit unit,
  }) = _Portion;

  factory Portion.fromJson(Map<String, dynamic> json) => _$PortionFromJson(json);
}
