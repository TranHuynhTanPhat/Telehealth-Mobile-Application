// ignore_for_file: unused_field
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/requests/feedback_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/data/api/models/responses/discount_response.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/data/api/models/responses/drug_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/data/api/models/responses/money_chart_response.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/data/api/models/responses/statistic_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/api/services/consultation_service.dart';
import 'package:healthline/repositories/base_repository.dart';

class ConsultationRepository extends BaseRepository {
  final ConsultationService _consultationService = ConsultationService();

  Future<DiscountResponse> checkDiscount({required String code}) async {
    return await _consultationService.checkDiscount(code: code);
  }

  Future<List<UserResponse>> getFamiliarCustomer(
      {required bool isDoctor}) async {
    return await _consultationService.getFamiliarCustomer(isDoctor: isDoctor);
  }

  Future<List<UserResponse>> getNewCustomer({required bool isDoctor}) async {
    return await _consultationService.getNewCustomer(isDoctor: isDoctor);
  }

  Future<StatisticResponse> fetchStatisticTable(
      {required bool isDoctor}) async {
    return await _consultationService.fetchStatisticTable(isDoctor: isDoctor);
  }

  Future<MoneyChartResponse> moneyChart(
      {required int year, required bool isDoctor}) async {
    return await _consultationService.moneyChart(
        year: year, isDoctor: isDoctor);
  }

  Future<List<int>> fetchTimeline(
      {required String id, required String date}) async {
    return await _consultationService.fetchTimeline(id: id, date: date);
  }

  Future<DoctorDasboardResponse> getDasboard() async {
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

  Future<PrescriptionResponse> fetchPrescription(
      {required String consultationId, required bool isDoctor}) async {
    return await _consultationService.fetchPrescription(
        consultationId: consultationId, isDoctor: isDoctor);
  }

  Future<List<DrugResponse>> searchDrug(
      {required String key, required int pageKey}) async {
    return await _consultationService.searchDrug(key: key, pageKey: pageKey);
  }

  Future<int?> createPrescription({required PrescriptionResponse prescriptionResponse, required String consultationId}) async{
    return await _consultationService.createPrescription(prescriptionResponse:prescriptionResponse, consultationId: consultationId);

  }

  Future<List<DiscountResponse>> fetchDiscount()async {
    return await _consultationService.fetchDiscount();

  }

  Future<int?>announceBusy({required String consultationId}) async {
    return await _consultationService.announceBusy(consultationId:consultationId);
  }

  Future<DrugResponse> getInfoDrug({required String id}) async {
    return await _consultationService.getInfoDrug(id:id);
  }
}
