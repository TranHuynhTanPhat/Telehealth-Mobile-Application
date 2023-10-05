import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/image_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repository/file_repository.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/utils/log_data.dart';

part 'health_info_state.dart';

class HealthInfoCubit extends HydratedCubit<HealthInfoState> {
  HealthInfoCubit() : super(HealthInfoInitial([], -1));
  final UserRepository _userRepository = UserRepository();
  final FileRepository _fileRepository = FileRepository();

  Future<void> fetchMedicalRecord() async {
    emit(HealthInfoLoading(state.subUsers, state.currentUser));
    try {
      List<UserResponse> userResponses =
          await _userRepository.fetchMdicalRecord();

      emit(HealthInfoLoaded(userResponses,
          userResponses.indexWhere((element) => element.isMainProfile!)));
    } catch (e) {
      logPrint(e.toString());
      emit(HealthInfoError(state.subUsers, state.currentUser));
    }
  }

  Future<void> addSubUser(String avatar, String fullName, String birthday,
      String gender, String relationship, String address) async {
    emit(AddUserLoading(state.subUsers, state.currentUser));
    try {
      String? mainUserId =
          state.subUsers.firstWhere((element) => element.isMainProfile!).id;
      if (mainUserId != null) {
        ImageResponse imageResponse = await _fileRepository.uploadImage(
            path: avatar,
            uploadPreset: dotenv.get('UPLOAD_PRESETS'),
            publicId: mainUserId + state.subUsers.length.toString(),
            folder: 'healthline/avatar/subusers');
        DataResponse response = await _userRepository.addSubUser(
            imageResponse.publicId!,
            fullName,
            birthday,
            gender,
            relationship,
            address);

        emit(AddUserSuccessfully(
            state.subUsers, state.currentUser, response.message));
      } else {
        emit(AddUserFailure(state.subUsers, state.currentUser, 'failure'));
      }
    } catch (e) {
      DioException er = e as DioException;

      emit(AddUserFailure(
          state.subUsers, state.currentUser, er.message.toString()));
    }
  }

  void updateIndex(int index) {
    emit(HealthInfoLoaded(state.subUsers, index));
  }

  Future<void> updateUser(File? avatar, String fullName, String birthday,
      String gender, String relationship, String address) async {
    emit(UpdateUserLoading(state.subUsers, state.currentUser));
    try {
      String? avt = state.subUsers[state.currentUser].avatar;
      String? id = state.subUsers[state.currentUser].id;

      if (id != null) {
        if (avatar != null) {
          if (avt != null) {
            ImageResponse imageResponse = await _fileRepository.uploadImage(
                path: avatar.path,
                uploadPreset: dotenv.get('UPLOAD_PRESETS'),
                publicId:
                    avt == 'default' ? id + state.currentUser.toString() : avt,
                folder: 'healthline/avatar/subusers');
            avt = imageResponse.publicId;
          }
        }
        DataResponse response = await _userRepository.updateSubUser(
            id,
            avt ?? 'default',
            fullName,
            birthday,
            gender,
            relationship,
            address);
        emit(UpdateUserSuccessfully(
            state.subUsers, state.currentUser, response.message));
      } else {
        emit(UpdateUserFailure(state.subUsers, state.currentUser, 'failure'));
      }
    } catch (e) {
      logPrint(e.toString());
      DioException er = e as DioException;

      emit(UpdateUserFailure(
          state.subUsers, state.currentUser, er.message.toString()));
    }
  }

  @override
  HealthInfoState? fromJson(Map<String, dynamic> json) {
    return HealthInfoState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(HealthInfoState state) {
    return state.toMap();
  }
}
