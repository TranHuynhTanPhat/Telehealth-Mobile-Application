import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repositories/consultation_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

import '../../../data/api/models/responses/file_response.dart';
import '../../../repositories/doctor_repository.dart';
import '../../../repositories/file_repository.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit() : super(DoctorProfileInitial(profile: DoctorResponse()));
  final DoctorRepository _doctorRepository = DoctorRepository();
  final FileRepository _fileRepository = FileRepository();
  final ConsultationRepository _consultationRepository = ConsultationRepository();

  Future<void> fetchProfile() async {
    emit(
      FetchProfileState(profile: state.profile, blocState: BlocState.Pending),
    );
    try {
      DoctorResponse profile = await _doctorRepository.fetchProfile();
      emit(FetchProfileState(profile: profile, blocState: BlocState.Successed));
    } on DioException catch (e) {
      // DioException er = e as DioException;
      emit(
        FetchProfileState(
          profile: state.profile,
          blocState: BlocState.Failed,
          error: e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      emit(
        FetchProfileState(
          profile: state.profile,
          blocState: BlocState.Failed,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchPatient() async {
    emit(
      FetchPatientState(
          profile: state.profile, blocState: BlocState.Pending, patients: []),
    );
    try {
      List<UserResponse> patients =
          await _consultationRepository.fetchPatient();
      emit(FetchPatientState(
          profile: state.profile,
          blocState: BlocState.Successed,
          patients: patients));
    } on DioException catch (e) {
      // DioException er = e as DioException;
      emit(
        FetchPatientState(
          profile: state.profile,
          blocState: BlocState.Failed,
          error: e.response!.data['message'].toString(),
          patients: [],
        ),
      );
    } catch (e) {
      emit(
        FetchPatientState(
          profile: state.profile,
          blocState: BlocState.Failed,
          error: e.toString(),
          patients: [],
        ),
      );
    }
  }

  Future<void> updateProfile(String? bio, String? path, String? email) async {
    emit(
      UpdateProfileState(profile: state.profile, blocState: BlocState.Pending),
    );
    bool error = false;
    try {
      if (bio != null && bio != state.profile.biography) {
        await updateBio(bio);
      }
    } catch (e) {
      error = true;
      emit(
        UpdateProfileState(
          profile: state.profile,
          blocState: BlocState.Failed,
          error: e.toString(),
        ),
      );
    }
    try {
      if (path != null) {
        await updateAvatar(path);
      }
    } catch (e) {
      error = true;

      emit(
        UpdateProfileState(
          profile: state.profile,
          blocState: BlocState.Failed,
          error: e.toString(),
        ),
      );
    }
    try {
      if (email != null && state.profile.email != email) {
        await updateEmail(email);
      }
    } catch (e) {
      error = true;

      emit(
        UpdateProfileState(
          profile: state.profile,
          blocState: BlocState.Failed,
          error: e.toString(),
        ),
      );
    }
    if (!error) {
      Future.delayed(const Duration(seconds: 3), () {
        emit(UpdateProfileState(
            profile: state.profile,
            blocState: BlocState.Successed,
            message: 'successfully'));
      });
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      await _doctorRepository.updateEmail(email);
    } on DioException catch (e) {
      throw e.response!.data['message'].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateBio(String bio) async {
    try {
      await _doctorRepository.updateBio(bio);
    } on DioException catch (e) {
      throw e.response!.data['message'].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAvatar(String path) async {
    try {
      String? id = state.profile.id;
      String? avatar = state.profile.avatar;
      if (id != null) {
        FileResponse fileResponse = await _fileRepository.uploadAvatarDoctor(
          path: path,
        );
        String publicId = fileResponse.publicId!;

        if (avatar != publicId) {
          await _doctorRepository.updateAvatar(publicId);
          emit(
            DoctorProfileState(
              profile: state.profile.copyWith(avatar: publicId),
            ),
          );
        } else {}
      } else {
        throw 'failed_to_update_avatar';
      }
    } on DioException catch (e) {
      throw e.response!.data['message'].toString();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onChange(Change<DoctorProfileState> change) {
    super.onChange(change);
    logPrint(change);
  }
}
