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
    Map<String, String> request = {"record_id": recordId};
    return await _vaccinationService.getInjectedVaccination(request);
  }
}
