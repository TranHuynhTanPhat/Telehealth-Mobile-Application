import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';

import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repositories/file_repository.dart';
import 'package:healthline/repositories/patient_repository.dart';
import 'package:healthline/repositories/user_repository.dart';
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
          message: e.response!.data['message'].toString(),
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
    } on DioException catch (e) {
      emit(
        HealthStatError(
          stats: state.stats,
          message: e.response!.data['message'].toString(),
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
    } on DioException catch (e) {
      logPrint(e);
      emit(FetchSubUserError(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
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
      int? code = await _userRepository.addMedicalRecord(
          'default', fullName, birthday, gender, relationship, address);
      if (code == 201 || code == 200) {
        emit(AddSubUserSuccessfully(
          stats: state.stats,
          subUsers: state.subUsers,
          currentId: state.currentId,
        ));
      } else {
        throw 'failure';
      }
      // if (recordId != null && avatar != null) {
      //   await _fileRepository.uploadAvatarPatient(
      //       path: avatar, publicId: recordId);
      // }
    } on DioException catch (e) {
      emit(AddSubUserFailure(
        stats: state.stats,
        message: e.response!.data['message'].toString(),
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    } catch (e) {
      logPrint(e);
      emit(AddSubUserFailure(
        stats: state.stats,
        message: e.toString(),
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
      UserResponse? user = state.subUsers.firstWhere(
          (element) => element.id == state.currentId,
          orElse: () => UserResponse());
      String? id = user.id;
      String? avatar = user.avatar;

      DateTime oldBD =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(user.dateOfBirth!);

      bool bdChanged = oldBD.day != int.parse(birthday.split('/')[0]) ||
          oldBD.month != int.parse(birthday.split('/')[1]) ||
          oldBD.year != int.parse(birthday.split('/')[2]);

      if (path != null) {
        if (id != null) {
          FileResponse fileResponse = await _fileRepository.uploadAvatarPatient(
              path: path, publicId: id);
          if (avatar != fileResponse.publicId ||
              fullName != user.fullName ||
              birthday != user.dateOfBirth ||
              gender != user.gender ||
              relationship != user.relationship!.name ||
              address != user.address ||
              bdChanged) {
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
      } else {
        if (id != null) {
          if (fullName != user.fullName ||
              birthday != user.dateOfBirth ||
              gender != user.gender ||
              relationship != user.relationship!.name ||
              address != user.address ||
              bdChanged) {
            await _userRepository.updateMedicalRecord(id, avatar ?? 'default',
                fullName, birthday, gender, relationship, address);
          }
        }
      }
      emit(UpdateSubUserSuccessfully(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    } on DioException catch (e) {
      emit(UpdateSubUserFailure(
        stats: state.stats,
        message: e.response!.data['message'].toString(),
        subUsers: state.subUsers,
        currentId: state.currentId,
      ));
    } catch (e) {
      emit(UpdateSubUserFailure(
        stats: state.stats,
        message: e.toString(),
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
    } on DioException catch (e) {
      emit(DeleteSubUserFailure(
        stats: state.stats,
        subUsers: state.subUsers,
        currentId: state.currentId,
        message: e.response!.data['message'].toString(),
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
