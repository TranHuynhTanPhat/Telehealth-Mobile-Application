// ignore_for_file: unused_field

import 'package:healthline/data/api/models/responses/top_doctor_response.dart';
import 'package:healthline/data/api/repositories/base_repository.dart';
import 'package:healthline/data/api/services/doctor_service.dart';

class DoctorRepository extends BaseRepository {
  final DoctorService _doctorService = DoctorService();

  Future<List<TopDoctorsResponse>> getDoctors() async {
    return await _doctorService.getDoctors();
  }
}
