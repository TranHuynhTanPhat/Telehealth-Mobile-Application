import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/health_stat_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
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

  Future<DataResponse> updateStats(HealthStatRequest request) async {
    final response =
        await put(ApiConstants.PATIENT_HEALTH_STAT, data: request.toJson());

    return response;
  }

  Future<DataResponse> addPatientRecord(String medicalId, String record) async {
    var request = json.encode({'medicalId': medicalId, 'record': record});
    final response = await post(ApiConstants.PATIENT_RECORD, data: request);

    return response;
  }

  Future<List<PatientRecordResponse>> getPatientRecord(String medicalId) async {
    final response = await get('${ApiConstants.PATIENT_RECORD}/$medicalId');
    List<PatientRecordResponse> records = response.data
        .map<PatientRecordResponse>((e) => PatientRecordResponse.fromMap(e))
        .toList();
    return records;
  }

  Future<DataResponse> deletePatientRecord(String medicalId) async {
    final response = await delete('${ApiConstants.PATIENT_RECORD}/$medicalId');

    return response;
  }
}
