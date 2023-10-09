// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/utils/log_data.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial(phone: null, email: null));
  final UserRepository _userRepository = UserRepository();
  @override
  void onChange(Change<ContactState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchContact() async {
    emit(ContactLoading(phone: state.phone, email: state.email));

    try {
      UserResponse userResponse = await _userRepository.fetchContact();

      emit(ContactLoaded(phone: userResponse.phone, email: userResponse.email));
    } catch (e) {
      DioException er = e as DioException;

      emit(ContactError(er.message.toString(),
          phone: null, email: null));
    }
  }

  Future<void> updateEmail(String email) async {
    emit(ContactLoading(phone: state.phone, email: email));

    try {
      DataResponse response = await _userRepository.updateEmail(email);
      // print(response.message);
      emit(ContactUpdate(phone: state.phone, email: email, response: response));
    } catch (e) {
      DioException er = e as DioException;
      emit(ContactError(er.response!.data['message'].toString(),
          phone: null, email: null));
    }
  }
}
