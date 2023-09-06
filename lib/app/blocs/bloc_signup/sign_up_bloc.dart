// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<NavigateToLogIn>(_navigateToLogIn);
  }

  FutureOr<void> _navigateToLogIn(
      NavigateToLogIn event, Emitter<SignUpState> emit) {
    emit(SignUpLoading());
    try {
      emit(NavigateToLogInActionState());
    } catch (e) {
      emit(SignUpError(message: e.toString()));
    }
  }
}
