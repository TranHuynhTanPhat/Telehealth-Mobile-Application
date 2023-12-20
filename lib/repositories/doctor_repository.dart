// ignore_for_file: unused_field

import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/data/api/services/doctor_service.dart';
import 'package:healthline/repositories/base_repository.dart';

class DoctorRepository extends BaseRepository {
  final DoctorService _doctorService = DoctorService();

  Future<DoctorResponse> fetchProfile() async {
    return await _doctorService.getProfile();
  }

  Future<List<ScheduleResponse>> fetchSchedule() async {
    return await _doctorService.getSchedule();
  }

  // Future<DataResponse> getScheduleCron() async {
  //   return await _doctorService.getScheduleCron();
  // }

  Future<DataResponse> updateBio(String bio) async {
    return await _doctorService.updateBio(bio);
  }

  Future<DataResponse> updateAvatar(String avatar) async {
    return await _doctorService.updateAvatar(avatar);
  }

  Future<DataResponse> updateEmail(String email) async {
    return await _doctorService.updateEmail(email);
  }

  Future<DataResponse> updateFixedSchedule(List<List<int>> fixedTime) async {
    return await _doctorService.updateFixedSchedule(fixedTime);
  }

  Future<DataResponse> updateScheduleByDay(
      List<int> workingTimes, String scheduleId) async {
    return await _doctorService.updateScheduleByDay(workingTimes, scheduleId);
  }

  Future<int?> changePassword(
      {required String password, required String newPassword}) async {
    return await _doctorService.changePassword(
        password: password, newPassword: newPassword);
  }

  Future<int?> sendOTP({required String email}) async {
    return await _doctorService.sendOTP(email: email);
  }

  Future<int?> resetPassword(
      {required String email,
      required String otp,
      required String password,
      required String confirmPassword}) async {
    return await _doctorService.resetPassword(
        email: email,
        otp: otp,
        password: password,
        confirmPassword: confirmPassword);
  }
}
