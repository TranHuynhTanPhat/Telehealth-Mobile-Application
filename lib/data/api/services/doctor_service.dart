
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class DoctorService extends BaseService {
  Future<List<DoctorResponse>> getDoctors() async {
    final response = await get(ApiConstants.DOCTOR_GET_PUBLIC);
    // List<DoctorResponse>? doctors =
    // List<Map<String, dynamic>> data = json.decode(response.data);
    List<dynamic> doctors = response.data.toList();
    return doctors.map((e) => DoctorResponse.fromMap(e)).toList();
  }
}
