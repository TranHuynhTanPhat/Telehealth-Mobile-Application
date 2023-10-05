// ignore_for_file: unused_field

import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/top_doctor_response.dart';
import 'package:healthline/repository/base_repository.dart';
import 'package:healthline/data/api/services/doctor_service.dart';

class DoctorRepository extends BaseRepository {
  final DoctorService _doctorService = DoctorService();

  Future<List<TopDoctorsResponse>> getDoctors() async {
    return await _doctorService.getDoctors();
  }

  Future<LoginResponse> login(String phone, String password) async {
    UserRequest request = UserRequest(phone: phone, password: password);
    return await _doctorService.login(request);
  }

  Future<void> refreshToken() async {
    await _doctorService.refreshToken();
  }
}
