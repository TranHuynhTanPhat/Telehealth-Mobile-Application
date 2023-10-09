import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class DoctorService extends BaseService {
  // Future<List<TopDoctorsResponse>> getDoctors() async {
  //   final response = await get(ApiConstants.DOCTOR_GET_PUBLIC);
  //   List<dynamic> doctors = response.data.toList();
  //   return doctors.map((e) => TopDoctorsResponse.fromMap(e)).toList();
  // }

  Future<List<ScheduleResponse>> getSchedule() async {
    final response = await get(ApiConstants.DOCTOR_SCHEDULE, isDoctor: true);
    List<ScheduleResponse> schedules = response.data
        .map<ScheduleResponse>((e) => ScheduleResponse.fromMap(e))
        .toList();
    return schedules;
  }

  Future<DataResponse> updateBio(String bio) async {
    var jsonRequest = json.encode({
      "biography": bio,
    });
    final response = await patch(ApiConstants.DOCTOR_CHANGE_BIOGRAPHY,
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
}
