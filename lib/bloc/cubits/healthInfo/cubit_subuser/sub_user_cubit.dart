import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/image_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repository/file_repository.dart';
import 'package:healthline/repository/user_repository.dart';

part 'sub_user_state.dart';

class SubUserCubit extends HydratedCubit<SubUserState> {
  SubUserCubit() : super(SubUserInitial([], -1));
  final UserRepository _userRepository = UserRepository();
  final FileRepository _fileRepository = FileRepository();

  Future<void> fetchMedicalRecord() async {
    emit(FetchSubUserLoading(state.subUsers, state.currentUser));
    try {
      List<UserResponse> userResponses =
          await _userRepository.fetchMdicalRecord();
      userResponses.forEach(
        (element) => print(element.toJson()),
      );

      emit(FetchSubUserLoaded(
          userResponses,
          state.currentUser == -1
              ? userResponses.indexWhere((element) => element.isMainProfile!)
              : state.currentUser));
    } catch (e) {
      emit(FetchSubUserError(state.subUsers, state.currentUser));
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
        DataResponse response = await _userRepository.addMedicalRecord(
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
    emit(FetchSubUserLoaded(state.subUsers, index));
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
        DataResponse response = await _userRepository.updateMedicalRecord(
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
      DioException er = e as DioException;

      emit(UpdateUserFailure(
          state.subUsers, state.currentUser, er.message.toString()));
    }
  }

  Future<void> deleteUser(String recordId) async {
    emit(DeleteUserLoading(state.subUsers, state.currentUser));
    try {
      DataResponse response = await _userRepository.deleteMedicalRecord(
        recordId,
      );
      emit(DeleteUserSuccessfully(
          state.subUsers, state.currentUser, response.message));
    } catch (e) {
      DioException er = e as DioException;

      emit(DeleteUserFailure(
          state.subUsers, state.currentUser, er.message.toString()));
    }
  }

  @override
  void onChange(Change<SubUserState> change) {
    super.onChange(change);
    logPrint(change);
  }

  @override
  SubUserState? fromJson(Map<String, dynamic> json) {
    return SubUserState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SubUserState state) {
    return state.toMap();
  }
}
