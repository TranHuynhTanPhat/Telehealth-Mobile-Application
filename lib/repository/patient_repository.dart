import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/services/patient_service.dart';
import 'package:healthline/repository/base_repository.dart';

class PatientRepository extends BaseRepository {
  final PatientService _patientService = PatientService();
  Future<List<HealthStatResponse>> fetchStats(String recordId) async {
    return await _patientService.getStats(recordId);
  }
}
