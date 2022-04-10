import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ETypeLocale { en, pl }

class LocaleCubit extends HydratedCubit<Locale> {
  LocaleCubit() : super(Locale('en', ''));

  void change(ETypeLocale eTypeLocale) async {
    switch (eTypeLocale) {
      case ETypeLocale.en:
        emit(Locale('en', ''));
        break;
      case ETypeLocale.pl:
        emit(Locale('pl', ''));
        break;
    }
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    return fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Locale state) {
    return toJson(state);
  }
}
