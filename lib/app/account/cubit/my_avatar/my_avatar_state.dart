part of 'my_avatar_cubit.dart';

@freezed
class MyAvatarState with _$MyAvatarState {
  const factory MyAvatarState.initial() = Initial;
  const factory MyAvatarState.loading() = Loading;
  const factory MyAvatarState.loaded(@Uint8ListConverter() Uint8List? uint8list) = Loaded;
  const factory MyAvatarState.error() = Error;

  factory MyAvatarState.fromJson(Map<String, dynamic> json) => _$MyAvatarStateFromJson(json);
}


class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    return json == null ? null : Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    return object?.toList();
  }
}