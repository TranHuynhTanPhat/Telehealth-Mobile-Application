// ignore_for_file: depend_on_referenced_packages, unused_import

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healthline/utils/log_data.dart';
import 'package:timezone/timezone.dart';

part 'res_state.dart';

class ResCubit extends HydratedCubit<ResState> {
  ResCubit(Locale locale) : super(ResInit(locale: locale, switchTheme: false));
  @override
  void onChange(Change<ResState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> toVietnamese() async {
    emit(
        LanguageChanging(locale: state.locale, switchTheme: state.switchTheme));
    await Future.delayed(const Duration(milliseconds: 300), () {
      emit(
          ResState(locale: const Locale('vi'), switchTheme: state.switchTheme));
    });
  }

  Future<void> toEnglish() async {
    emit(
        LanguageChanging(locale: state.locale, switchTheme: state.switchTheme));
    await Future.delayed(const Duration(milliseconds: 300), () {
      emit(
          ResState(locale: const Locale('en'), switchTheme: state.switchTheme));
    });
  }

  void toLightTheme() =>
      emit(ResState(locale: state.locale, switchTheme: false));
  void toDartTheme() => emit(ResState(locale: state.locale, switchTheme: true));

  @override
  ResState? fromJson(Map<String, dynamic> json) {
    return ResState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ResState state) {
    return state.toMap();
  }
}
