import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ETypeLocale { en, pl }

class LocaleCubit extends HydratedCubit<Locale> {
  LocaleCubit() : super(Locale('en', ''));

  void change(ETypeLocale eTypeLocale) async => emit(_toLocale(eTypeLocale));

  @override
  Locale? fromJson(Map<String, dynamic> json) => _toLocale(json.values.first);

  @override
  Map<String, dynamic>? toJson(Locale state) =>
      <String, dynamic>{'languageCode': state.languageCode};

  Locale _toLocale(ETypeLocale eTypeLocale) {
    switch (eTypeLocale) {
      case ETypeLocale.en:
        return Locale('en', '');
      case ETypeLocale.pl:
        return Locale('pl', '');
    }
  }
}
