import 'package:healthline/data/api/models/requests/injected_vaccination_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/vaccination_response.dart';
import 'package:healthline/data/api/services/vaccination_service.dart';
import 'package:healthline/repositories/base_repository.dart';

class VaccinationRepository extends BaseRepository {
  final VaccinationService _vaccinationService = VaccinationService();
  Future<List<VaccinationResponse>> fetchVaccination() async {
    return await _vaccinationService.getVaccination();
  }

  Future<List<InjectedVaccinationResponse>> fetchInjectedVaccination(
      String recordId) async {
    // Map<String, String> request = {"record_id": recordId};
    return await _vaccinationService.getInjectedVaccination(recordId);
  }

  Future<InjectedVaccinationResponse> createInjectedVaccination(
      String recordId, String vaccineId, int doseNumber, String date) async {
    InjectedVaccinationRequest request = InjectedVaccinationRequest(
        medicalRecord: recordId,
        vaccineId: vaccineId,
        doseNumber: doseNumber,
        date: date);
    return await _vaccinationService.createInjectedVaccination(request);
  }

  Future<InjectedVaccinationResponse> updateInjectedVaccination(
      String recordId, int doseNumber, String date) async {
    InjectedVaccinationRequest request = InjectedVaccinationRequest(
        recorId: recordId, doseNumber: doseNumber, date: date);
    return await _vaccinationService.updateInjectedVaccination(request);
  }

  Future<DataResponse> deleteInjectedVaccination(String recordId) async {
    return await _vaccinationService.deleteInjectedVaccination(recordId);
  }
}
