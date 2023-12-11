import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/api/models/responses/base/data_response.dart';
import '../../../data/api/models/responses/file_response.dart';
import '../../../repository/doctor_repository.dart';
import '../../../repository/file_repository.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends HydratedCubit<DoctorProfileState> {
  DoctorProfileCubit() : super(DoctorProfileInitial(null));
  final DoctorRepository _doctorRepository = DoctorRepository();
  final FileRepository _fileRepository = FileRepository();

  Future<void> fetchProfile() async {
    emit(FetchDoctorProfileLoading(state.profile));
    try {
      DoctorResponse profile = await _doctorRepository.fetchProfile();
      emit(DoctorProfileInitial(profile));
    } catch (e) {
      // DioException er = e as DioException;
      emit(FetchDoctorProfileError(state.profile));
    }
  }

  Future<void> updateProfile(String? bio, String? path, String? email) async {
    emit(
      DoctorProfileUpdating(state.profile),
    );
    if (bio != null) {
      await updateBio(bio);
    }
    if (path != null) {
      await updateAvatar(path);
    }
    if (email != null) {
      await updateEmail(email);
    }
    emit(DoctorProfileUpdateSuccessfully(state.profile));
  }

  Future<void> updateEmail(String email) async {
    emit(DoctorEmailUpdating(state.profile));
    try {
      DataResponse response = await _doctorRepository.updateEmail(email);
      if (response.success) {
        emit(
          DoctorEmailSuccessfully(
            state.profile?.copyWith(
              email: response.data['email'],
            ),
          ),
        );
      }
    } on DioException catch (e) {
      emit(DoctorEmailError(state.profile, message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(DoctorEmailError(state.profile, message: e.toString()));
    }
  }

  Future<void> updateBio(String bio) async {
    emit(DoctorBiographyUpdating(state.profile));
    try {
      DataResponse response = await _doctorRepository.updateBio(bio);
      if (response.success) {
        emit(
          DoctorBiographySuccessfully(
            state.profile?.copyWith(
              biography: response.data['biography'],
            ),
          ),
        );
      }
    } on DioException catch (e) {
      emit(DoctorBiographyError(state.profile, message: e.response!.data['message'].toString()));
    } catch (e) {
      emit(DoctorBiographyError(state.profile, message: e.toString()));
    }
  }

  Future<void> updateAvatar(String path) async {
    emit(DoctorAvatarUpdating(state.profile));
    try {
      String? id = state.profile?.id;
      String? avatar = state.profile?.avatar;
      if (id != null) {
        FileResponse fileResponse = await _fileRepository.uploadAvatarDoctor(
          path: path,
        );
        String publicId = fileResponse.publicId!;

        if (avatar != publicId) {
          await _doctorRepository.updateAvatar(publicId);
          emit(
            DoctorAvatarSuccessfully(
              state.profile?.copyWith(avatar: publicId),
            ),
          );
        } else {
          emit(
            DoctorAvatarSuccessfully(state.profile),
          );
        }
      } else {
        emit(
          DoctorAvatarError(
            state.profile,
            message: 'failure',
          ),
        );
      }
    } on DioException catch (e) {
      emit(
        DoctorAvatarError(
          state.profile,
          message: e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      emit(
        DoctorAvatarError(
          state.profile,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  DoctorProfileState? fromJson(Map<String, dynamic> json) {
    return DoctorProfileState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(DoctorProfileState state) {
    return state.toMap();
  }

  @override
  void onChange(Change<DoctorProfileState> change) {
    super.onChange(change);
    logPrint(change);
  }
}
