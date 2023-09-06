// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitial()) {
    on<NavigateToSignUp>(_navigateToSignUp);
  }

  FutureOr<void> _navigateToSignUp(
      NavigateToSignUp event, Emitter<LogInState> emit) {
        emit(NavigateToSignUpActionState());
      }
}
