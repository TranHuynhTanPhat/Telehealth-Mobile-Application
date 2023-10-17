import 'package:dio/dio.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repository/file_repository.dart';
import 'package:healthline/repository/patient_repository.dart';
import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';

part 'medical_record_state.dart';

class MedicalRecordCubit extends HydratedCubit<MedicalRecordState> {
  MedicalRecordCubit()
      : super(MedicalRecordInitial(stats: [], subUsers: [], currentId: null));

  final PatientRepository _patientRepository = PatientRepository();
  final UserRepository _userRepository = UserRepository();
  final FileRepository _fileRepository = FileRepository();

  @override
  void onChange(Change<MedicalRecordState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchStats() async {
    emit(HealthStatLoading(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId));
    try {
      List<HealthStatResponse> stats =
          await _patientRepository.fetchStats(state.currentId!);
      emit(HealthStatLoaded(
          stats: stats, subUsers: state.subUsers, currentId: state.currentId));
    } on DioException catch (e) {
      emit(
        HealthStatError(
          stats: state.stats,
          message: e.message.toString(),
          subUsers: state.subUsers,
          currentId: state.currentId,
        ),
      );
    } catch (e) {
      emit(
        HealthStatError(
          stats: state.stats,
          message: e.toString(),
          subUsers: state.subUsers,
          currentId: state.currentId,
        ),
      );
    }
  }

  Future<void> updateStats(String medicalId, String bloodGroup, num heartRate,
      num height, num weight, num headCircumference, num temperature) async {
    emit(UpdateStatLoading(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId));
    try {
      num? blG;
      num? hR;
      num? h;
      num? w;
      num? t;
      num? hc;
      blG = bloodGroup == 'A'
          ? 0
          : bloodGroup == 'B'
              ? 1
              : bloodGroup == 'O'
                  ? 2
                  : bloodGroup == 'AB'
                      ? 3
                      : null;
      blG = blG ==
              state.stats
                  .firstWhere(
                    (element) => element.type == TypeHealthStat.Blood_group,
                    orElse: () => HealthStatResponse(),
                  )
                  .value
          ? null
          : blG;
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
      hc = headCircumference == 0 ? null : headCircumference;
      if (blG == null &&
          hR == null &&
          h == null &&
          w == null &&
          hc == null &&
          t == null) {
        emit(NoChange(
          stats: state.stats,
          subUsers: state.subUsers,
          currentId: state.currentId,
        ));
      } else {
        await _patientRepository.updateStats(medicalId, blG, hR, h, w, hc, t);
        emit(UpdateStatSuccessfully(
          stats: state.stats,
          subUsers: state.subUsers,
          currentId: state.currentId,
        ));
      }
    } catch (e) {
      DioException er = e as DioException;

      emit(
        HealthStatError(
          stats: state.stats,
          message: er.message.toString(),
          subUsers: state.subUsers,
          currentId: state.currentId,
        ),
      );
    }
  }

  /// sub user
  Future<void> fetchMedicalRecord() async {
    emit(FetchSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentId: state.currentId,
    ));
    try {
      List<UserResponse> userResponses =
          await _userRepository.fetchMdicalRecord();

      emit(FetchSubUserLoaded(
          stats: state.stats,
          subUsers: userResponses,
          currentId: state.subUsers
                  .where((element) => element.id == state.currentId)
                  .toList()
                  .isEmpty
              ? userResponses.firstWhere((element) => element.isMainProfile!).id
              : state.currentId));
      await fetchStats();
    } catch (e) {
      emit(FetchSubUserError(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    }
  }

  Future<void> addSubUser(String? avatar, String fullName, String birthday,
      String gender, String relationship, String address) async {
    emit(AddSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentId: state.currentId,
    ));
    try {
      DataResponse response = await _userRepository.addMedicalRecord(
          'default', fullName, birthday, gender, relationship, address);
      String? recordId = response.data['record_id'];
      if (recordId != null && avatar != null) {
        await _fileRepository.uploadAvatarUser(
            path: avatar, publicId: recordId);
      }

      emit(AddSubUserSuccessfully(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    } catch (e) {
      DioException er = e as DioException;

      emit(AddSubUserFailure(
        stats: state.stats,
        message: er.message.toString(),
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    }
  }

  void updateCurrentId(String id) {
    emit(UpdateCurrentId(
        stats: state.stats, subUsers: state.subUsers, currentId: id));
  }

  Future<void> updateSubUser(String? path, String fullName, String birthday,
      String gender, String? relationship, String address) async {
    emit(UpdateSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentId: state.currentId,
    ));
    try {
      String? id = state.subUsers
          .firstWhere((element) => element.id == state.currentId)
          .id;
      String? avatar = state.subUsers
          .firstWhere((element) => element.id == state.currentId)
          .avatar;

      if (path != null) {
        if (id != null) {
          print(id);
          FileResponse fileResponse =
              await _fileRepository.uploadAvatarUser(path: path, publicId: id);
              print(fileResponse.publicId);
          if (avatar != fileResponse.publicId) {
            await _userRepository.updateMedicalRecord(
                id,
                fileResponse.publicId!,
                fullName,
                birthday,
                gender,
                relationship,
                address);
          }
        }
      }
      // await _userRepository.updateMedicalRecord(
      //     id, avt!, fullName, birthday, gender, relationship, address);
      // List<UserResponse> newLists = state.subUsers;
      // int index = newLists.indexWhere(
      //   (element) => element.id == id,
      // );
      // newLists[index] = newLists[index].copyWith(
      //     avatar: avt,
      //     fullName: fullName,
      //     dateOfBirth: birthday,
      //     gender: gender,
      //     relationship: relationship != null
      //         ? Relationship.values.firstWhere((e) => e.name == relationship)
      //         : null,
      //     address: address);
      emit(UpdateSubUserSuccessfully(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    } catch (e) {
      DioException er = e as DioException;

      emit(UpdateSubUserFailure(
        stats: state.stats,
        message: er.message.toString(),
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    }
  }

  Future<void> deleteSubUser(String recordId) async {
    emit(DeleteSubUserLoading(
      stats: state.stats,
      subUsers: state.subUsers,
      currentId: state.currentId,
    ));
    try {
      await _userRepository.deleteMedicalRecord(
        recordId,
      );
      emit(DeleteSubUserSuccessfully(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.subUsers.first.id,
      ));
    } catch (e) {
      emit(DeleteSubUserFailure(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId,
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
