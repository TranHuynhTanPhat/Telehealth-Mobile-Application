// ignore_for_file: unused_field
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
import 'package:healthline/data/api/services/consultation_service.dart';
import 'package:healthline/repository/base_repository.dart';

class ConsultationRepository extends BaseRepository {
  final ConsultationService _consultationService = ConsultationService();

  Future<List<int>> fetchTimeline(
      {required String id, required String date}) async {
    return await _consultationService.fetchTimeline(id: id, date: date);
  }

  Future<int?> createConsultation(
      {required ConsultationRequest request}) async {
    return await _consultationService.createConsultation(request: request);
  }

  Future<AllConsultationResponse> fetchPatientConsultation() async {
    return await _consultationService.fetchPatientConsultation();
  }
}
