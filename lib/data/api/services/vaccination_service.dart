import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/injected_vaccination_request.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/vaccination_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class VaccinationService extends BaseService {
  Future<List<VaccinationResponse>> getVaccination() async {
    final response = await get(ApiConstants.VACCINATION_VACCINE);
    List<VaccinationResponse> vaccinations = response.data
        .map<VaccinationResponse>((e) => VaccinationResponse.fromMap(e))
        .toList();
    return vaccinations;
  }

  Future<List<InjectedVaccinationResponse>> getInjectedVaccination(
      String recordId) async {
    final response =
        await get('${ApiConstants.VACCINATION_RECORD}/$recordId');
    List<InjectedVaccinationResponse> vaccinations = response.data
        .map<InjectedVaccinationResponse>(
            (e) => InjectedVaccinationResponse.fromMap(e))
        .toList();
    return vaccinations;
  }

  Future<InjectedVaccinationResponse> createdInjectedVaccination(
      InjectedVaccinationRequest request) async {
    final response =
        await post(ApiConstants.VACCINATION_RECORD, data: request.toJson());
   
    return InjectedVaccinationResponse.fromMap(response.data);
  }
}
