
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/responses/top_doctor_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class DoctorService extends BaseService {
  Future<List<TopDoctorsResponse>> getDoctors() async {
    final response = await get(ApiConstants.DOCTOR_GET_PUBLIC);
    List<dynamic> doctors = response.data.toList();
    return doctors.map((e) => TopDoctorsResponse.fromMap(e)).toList();
  }
}
