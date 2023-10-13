import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/health_stat_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class PatientService extends BaseService {
  Future<List<HealthStatResponse>> getStats(String medicalId) async {
    final response =
        await get('${ApiConstants.PATIENT_HEALTH_STAT}/$medicalId');
    List<HealthStatResponse> stats = response.data
        .map<HealthStatResponse>((e) => HealthStatResponse.fromMap(e))
        .toList();
    return stats;
  }

  Future<DataResponse> updateStats(
      HealthStatRequest request) async {

    final response =
        await put(ApiConstants.PATIENT_HEALTH_STAT, data: request.toJson());

    return response;
  }
}
