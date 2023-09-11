// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'error_state.dart';

class ErrorCubit extends Cubit<ErrorState> {
  ErrorCubit() : super(ErrorInitial(FirebaseStorage.instance.ref()));
  Future<void> getURL() async {
    try {
      String url = await state.ref
          .child('error/lotties')
          .child("error_2.json")
          .getDownloadURL();
      emit(ErrorLoaded(state.ref, url: url));
    } catch (error) {
      emit(ErrorInvalid(state.ref, message: error.toString()));
    }
  }
}
