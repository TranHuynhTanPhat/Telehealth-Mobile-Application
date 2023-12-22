// ignore_for_file: unused_field
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/requests/feedback_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/api/services/consultation_service.dart';
import 'package:healthline/repositories/base_repository.dart';

class ConsultationRepository extends BaseRepository {
  final ConsultationService _consultationService = ConsultationService();

  Future<List<int>> fetchTimeline(
      {required String id, required String date}) async {
    return await _consultationService.fetchTimeline(id: id, date: date);
  }
  Future<DoctorDasboardResponse> getDasboard(
     ) async {
    return await _consultationService.getDashboard();
  }

  Future<int?> createConsultation(
      {required ConsultationRequest request}) async {
    return await _consultationService.createConsultation(request: request);
  }

  Future<int?> cancelConsultation({required String consultationId}) async {
    return await _consultationService.cancelConsultation(
        consultationId: consultationId);
  }

  Future<AllConsultationResponse> fetchPatientConsultation() async {
    return await _consultationService.fetchPatientConsultation();
  }

  Future<AllConsultationResponse> fetchDoctorConsultation() async {
    return await _consultationService.fetchDoctorConsultation();
  }

  Future<List<UserResponse>> fetchPatient() async {
    return await _consultationService.fetchPatient();
  }

  Future<ConsultationResponse> fetchDetailDoctorConsultation(
      {required String consultationId}) async {
    return await _consultationService.fetchDetailDoctorConsultation(
        consultationId: consultationId);
  }

  Future<int?> confirmConsultation({required String consultationId}) async {
    return await _consultationService.confirmConsultation(
        consultationId: consultationId);
  }

  Future<int?> deleteConsultation({required String consultationId}) async {
    return await _consultationService.deleteConsultation(
        consultationId: consultationId);
  }

  Future<int?> createFeeback({required FeedbackRequest request}) async {
    return await _consultationService.createFeeback(request: request);
  }

  Future<List<FeedbackResponse>> fetchFeedbackDoctor(
      {required String doctorId}) async {
    return await _consultationService.fetchFeedbackDoctor(doctorId: doctorId);
  }

  Future<List<FeedbackResponse>> fetchFeedbackUser(
      {required String userId}) async {
    return await _consultationService.fetchFeedbackUser(userId: userId);
  }
}
