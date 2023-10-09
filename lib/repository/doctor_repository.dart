// ignore_for_file: unused_field

import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/data/api/services/doctor_service.dart';
import 'package:healthline/repository/base_repository.dart';

class DoctorRepository extends BaseRepository {
  final DoctorService _doctorService = DoctorService();

  // Future<List<TopDoctorsResponse>> getDoctors() async {
  //   return await _doctorService.getDoctors();
  // }

  Future<List<ScheduleResponse>> fetchSchedule() async {
    return await _doctorService.getSchedule();
  }

  Future<DataResponse> updateBio(String bio) async {
    return await _doctorService.updateBio(bio);
  }

  Future<DataResponse> updateAvatar(String avatar) async {
    return await _doctorService.updateBio(avatar);
  }
}