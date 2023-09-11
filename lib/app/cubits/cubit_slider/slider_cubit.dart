// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthline/utils/log_data.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial(FirebaseStorage.instance.ref()));
  Future<void> getURL(String fileName) async {
    try {
      String url = await state.ref
          .child('onboarding/images')
          .child(fileName)
          .getDownloadURL();
      emit(SliderLoaded(state.ref, url: url));
    } catch (error) {
      logPrint(error);
      emit(SliderError(state.ref, message: error.toString()));
    }
  }
}
