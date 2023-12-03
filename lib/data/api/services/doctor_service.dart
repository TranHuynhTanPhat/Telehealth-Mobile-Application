import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/doctor_profile_response.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class DoctorService extends BaseService {
  // Future<List<TopDoctorsResponse>> getDoctors() async {
  //   final response = await get(ApiConstants.DOCTOR_GET_PUBLIC);
  //   List<dynamic> doctors = response.data.toList();
  //   return doctors.map((e) => TopDoctorsResponse.fromMap(e)).toList();
  // }

  Future<DoctorProfileResponse> getProfile() async {
    final response = await get(ApiConstants.DOCTOR, isDoctor: true);

    return DoctorProfileResponse.fromMap(response.data);
  }

  Future<List<ScheduleResponse>> getSchedule() async {
    final response = await get(ApiConstants.DOCTOR_SCHEDULE, isDoctor: true);
    List<ScheduleResponse> schedules = response.data
        .map<ScheduleResponse>((e) => ScheduleResponse.fromMap(e))
        .toList();
    return schedules;
  }

  // Future<DataResponse> getScheduleCron() async {
  //   final response =
  //       await get(ApiConstants.DOCTOR_SCHEDULE_CRON, isDoctor: true);
  //   // List<ScheduleResponse> schedules = response.data
  //   //     .map<ScheduleResponse>((e) => ScheduleResponse.fromMap(e))
  //   //     .toList();
  //   return response;
  // }

  Future<DataResponse> updateBio(String bio) async {
    var jsonRequest = json.encode({
      "biography": bio,
    });
    final response = await patch(ApiConstants.DOCTOR_CHANGE_BIOGRAPHY,
        data: jsonRequest, isDoctor: true);

    return response;
  }

  Future<DataResponse> updateEmail(String email) async {
    var jsonRequest = json.encode({
      "email": email,
    });
    final response = await patch(ApiConstants.DOCTOR_CHANGE_EMAIL,
        data: jsonRequest, isDoctor: true);

    return response;
  }

  Future<DataResponse> updateAvatar(String avatar) async {
    var jsonRequest = json.encode({
      "avatar": avatar,
    });
    final response = await patch(ApiConstants.DOCTOR_CHANGE_AVATAR,
        data: jsonRequest, isDoctor: true);

    return response;
  }

  Future<DataResponse> updateFixedSchedule(List<List<int>> fixTime) async {
    var jsonRequest = json.encode({
      "fixed_times": fixTime,
    });
    final response = await patch(ApiConstants.DOCTOR_CHANGE_FIXED_TIMES,
        data: jsonRequest, isDoctor: true);

    return response;
  }

  Future<DataResponse> updateScheduleByDay(
      List<int> workingTimes, String scheduleId) async {
    var jsonRequest =
        json.encode({"schedule_id": scheduleId, "working_times": workingTimes});
    final response = await post(ApiConstants.DOCTOR_SCHEDULE,
        data: jsonRequest, isDoctor: true);

    return response;
  }

  Future<List<DoctorProfileResponse>> getListDoctor() async {
    final response = await get(ApiConstants.DOCTOR_LIST);
    List<DoctorProfileResponse> doctors = response.data
        .map<DoctorProfileResponse>((e) => DoctorProfileResponse.fromMap(e))
        .toList();
    return doctors;
  }
}
