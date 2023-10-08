import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class PatientService extends BaseService {

  Future<List<HealthStatResponse>> getStats(String recordId) async {
    final response =
        await get('${ApiConstants.PATIENT_HEALTH_STAT}/$recordId');
    List<HealthStatResponse> stats = response.data
        .map<HealthStatResponse>(
            (e) => HealthStatResponse.fromMap(e))
        .toList();
    return stats;
  }
}
