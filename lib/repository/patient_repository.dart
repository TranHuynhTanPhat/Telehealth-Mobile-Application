import 'package:healthline/data/api/models/requests/health_stat_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/services/patient_service.dart';
import 'package:healthline/repository/base_repository.dart';
import 'package:healthline/res/style.dart';

class PatientRepository extends BaseRepository {
  final PatientService _patientService = PatientService();
  Future<List<HealthStatResponse>> fetchStats(String medicalId) async {
    return await _patientService.getStats(medicalId);
  }

  Future<DataResponse> updateStats(
      String medicalId,
      int? bloodGroup,
      int? heartRate,
      int? height,
      int? weight,
      int? headCircumference,
      int? temperature) async {
    HealthStatRequest request =
        HealthStatRequest(medicalId: medicalId, stats: []);
    if (height != null) {
      request.stats!.add(HealthStatResponse(
          type: TypeHealthStat.Height, value: height, unit: 'cm'));
    }
    if (weight != null) {
      request.stats!.add(HealthStatResponse(
          type: TypeHealthStat.Weight, value: weight, unit: 'Kg'));
    }
    if (heartRate != null) {
      request.stats!.add(HealthStatResponse(
          type: TypeHealthStat.Heart_rate, value: heartRate, unit: 'bpm'));
    }
    if (bloodGroup != null) {
      request.stats!.add(HealthStatResponse(
          type: TypeHealthStat.Blood_group, value: bloodGroup, unit: ''));
    }
    if (headCircumference != null) {
      request.stats!.add(HealthStatResponse(
          type: TypeHealthStat.Head_cricumference,
          value: headCircumference,
          unit: 'cm'));
    }
    if(temperature!=null) {
      request.stats!.add(HealthStatResponse(
        type: TypeHealthStat.Temperature, value: temperature, unit: 'Celsius'));
    }
    if(request.stats!.isNotEmpty) {
      return await _patientService.updateStats(request);
    }
    else {
      return DataResponse(data: null, message: null);
    }
  }
}
