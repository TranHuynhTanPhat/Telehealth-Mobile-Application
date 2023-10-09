import 'package:healthline/data/api/models/requests/injected_vaccination_request.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/vaccination_response.dart';
import 'package:healthline/data/api/services/vaccination_service.dart';
import 'package:healthline/repository/base_repository.dart';

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
    return await _vaccinationService.createdInjectedVaccination(request);
  }
}