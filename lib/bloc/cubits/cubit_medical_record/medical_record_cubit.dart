import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/models/responses/image_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repository/file_repository.dart';
import 'package:healthline/repository/patient_repository.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'medical_record_state.dart';

class MedicalRecordCubit extends HydratedCubit<MedicalRecordState> {
  MedicalRecordCubit()
      : super(MedicalRecordInitial(stats: [], subUsers: [], currentUser: 0));

  final PatientRepository _patientRepository = PatientRepository();
  final UserRepository _userRepository = UserRepository();
  final FileRepository _fileRepository = FileRepository();

  @override
  void onChange(Change<MedicalRecordState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchStats(String medicalId) async {
    emit(HealthStatLoading(
        stats: state.stats,
        subUsers: state.subUsers,
        currentUser: state.currentUser));
    try {
      List<HealthStatResponse> stats =
          await _patientRepository.fetchStats(medicalId);
      emit(HealthStatLoaded(
          stats: stats,
          subUsers: state.subUsers,
          currentUser: state.currentUser));
    } on DioException catch (e) {
      emit(
        HealthStatError(
          stats: state.stats,
          message: e.message.toString(),
          subUsers: state.subUsers,
          currentUser: state.currentUser,
        ),
      );
    } catch (e) {
      emit(
        HealthStatError(
          stats: state.stats,
          message: e.toString(),
          subUsers: state.subUsers,
          currentUser: state.currentUser,
        ),
      );
    }
  }

  Future<void> updateStats(String medicalId, String bloodGroup, int heartRate,
      int height, int weight, int headCircumference, int temperature) async {
    emit(UpdateStatLoading(
        stats: state.stats,
        subUsers: state.subUsers,
        currentUser: state.currentUser));
    try {
      int? blG;
      int? hR;
      int? h;
      int? w;
      int? t;
      int? hc;
      blG = bloodGroup == 'A'
          ? 0
          : bloodGroup == 'B'
              ? 1
              : bloodGroup == 'O'
                  ? 2
                  : bloodGroup == 'AB'
                      ? 3
                      : null;
      hR = heartRate ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Heart_rate,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : heartRate;
      h = height ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Height,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : height;
      w = weight ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Weight,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : weight;
      t = temperature ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Temperature,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : temperature;
      hc = headCircumference ==
              state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Temperature,
                      orElse: () => HealthStatResponse())
                  .value
          ? null
          : headCircumference;
      if (blG == null &&
          hR == null &&
          h == null &&
          w == null &&
          hc == null &&
          t == null) {
        emit(UpdateStatSuccessfully(
          stats: state.stats,
          subUsers: state.subUsers,
          currentUser: state.currentUser,
        ));
      } else {
        await _patientRepository.updateStats(medicalId, blG, hR, h, w, hc, t);
        emit(UpdateStatSuccessfully(
          stats: state.stats,
          subUsers: state.subUsers,
          currentUser: state.currentUser,
        ));
        await fetchStats(medicalId);
      }
    } catch (e) {
      DioException er = e as DioException;

      emit(
        HealthStatError(
          stats: state.stats,
          message: er.message.toString(),
          subUsers: state.subUsers,
          currentUser: state.currentUser,
        ),
      );
    }
  }

  /// sub user
  Future<void> fetchMedicalRecord() async {
    emit(FetchSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentUser: state.currentUser,
    ));
    try {
      List<UserResponse> userResponses =
          await _userRepository.fetchMdicalRecord();

      emit(FetchSubUserLoaded(
          stats: state.stats,
          subUsers: userResponses,
          currentUser: state.currentUser > state.subUsers.length
              ? userResponses.indexWhere((element) => element.isMainProfile!)
              : state.currentUser));
    } catch (e) {
      emit(FetchSubUserError(
        stats: state.stats,
        subUsers: state.subUsers,
        currentUser: state.currentUser,
      ));
    }
  }

  Future<void> addSubUser(String avatar, String fullName, String birthday,
      String gender, String relationship, String address) async {
    emit(AddSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentUser: state.currentUser,
    ));
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

        emit(AddSubUserSuccessfully(
          stats: state.stats,
          subUsers: state.subUsers,
          currentUser: state.currentUser,
          message: response.message,
        ));
      } else {
        emit(AddSubUserFailure(
          stats: state.stats,
          subUsers: state.subUsers,
          currentUser: state.currentUser,
          message: 'failure',
        ));
      }
    } catch (e) {
      DioException er = e as DioException;

      emit(AddSubUserFailure(
        stats: state.stats,
        message: er.message.toString(),
        subUsers: state.subUsers,
        currentUser: state.currentUser,
      ));
    }
  }

  void updateIndex(int index) {
    emit(UpdateIndexSubUser(
        stats: state.stats, subUsers: state.subUsers, currentUser: index));
  }

  Future<void> updateSubUser(String? path, String fullName, String birthday,
      String gender, String? relationship, String address) async {
    emit(UpdateSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentUser: state.currentUser,
    ));
    try {
      String? avt = state.subUsers[state.currentUser].avatar;
      String? id = state.subUsers[state.currentUser].id;

      if (id != null) {
        if (path != null) {
          if (avt != null) {
            ImageResponse imageResponse = await _fileRepository.uploadImage(
                path: path,
                uploadPreset: dotenv.get('UPLOAD_PRESETS'),
                publicId:
                    avt == 'default' ? id + state.currentUser.toString() : avt,
                folder: '');
            avt = imageResponse.publicId;
          }
        }
        DataResponse response = await _userRepository.updateMedicalRecord(
            id, avt!, fullName, birthday, gender, relationship, address);
        List<UserResponse> newLists = state.subUsers;
        int index = newLists.indexWhere(
          (element) => element.id == id,
        );
        newLists[index] = newLists[index].copyWith(
            avatar: avt,
            fullName: fullName,
            dateOfBirth: birthday,
            gender: gender,
            relationship: relationship != null
                ? Relationship.values.firstWhere((e) => e.name == relationship)
                : null,
            address: address);
        emit(UpdateSubUserSuccessfully(
          stats: state.stats,
          message: response.message,
          subUsers: newLists,
          currentUser: state.currentUser,
        ));
      } else {
        emit(UpdateSubUserFailure(
          stats: state.stats,
          message: 'failure',
          subUsers: state.subUsers,
          currentUser: state.currentUser,
        ));
      }
    } catch (e) {
      DioException er = e as DioException;

      emit(UpdateSubUserFailure(
        stats: state.stats,
        message: er.message.toString(),
        subUsers: state.subUsers,
        currentUser: state.currentUser,
      ));
    }
  }

  Future<void> deleteSubUser(String recordId) async {
    emit(DeleteSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentUser: state.currentUser,
    ));
    try {
      await _userRepository.deleteMedicalRecord(
        recordId,
      );
      emit(DeleteSubUserSuccessfully(
        stats: state.stats,
        subUsers: state.subUsers,
        currentUser: state.currentUser,
      ));
    } catch (e) {
      emit(DeleteSubUserFailure(
        stats: state.stats,
        subUsers: state.subUsers,
        currentUser: state.currentUser,
        message: e.toString(),
      ));
    }
  }

  @override
  MedicalRecordState? fromJson(Map<String, dynamic> json) {
    return MedicalRecordState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(MedicalRecordState state) {
    return state.toMap();
  }
}
