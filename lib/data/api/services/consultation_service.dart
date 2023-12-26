import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/requests/feedback_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class ConsultationService extends BaseService {
  Future<List<int>> fetchTimeline(
      {required String id, required String date}) async {
    final response = await post(
        '${ApiConstants.CONSULTATION_DOCTOR}/$id/schedule',
        data: jsonEncode({'date': date}));
    List<int> timeline = List<int>.from(response.data);

    return timeline;
  }

  Future<DoctorDasboardResponse> getDashboard() async {
    final response =
        await get(ApiConstants.CONSULTATION_DOCTOR_DASHBOARD, isDoctor: true);

    return DoctorDasboardResponse.fromMap(response.data);
  }

  Future<int?> createConsultation(
      {required ConsultationRequest request}) async {
    final response =
        await post(ApiConstants.CONSULTATION, data: request.toJson());

    return response.code;
  }

  Future<int?> cancelConsultation({required String consultationId}) async {
    final response =
        await delete('${ApiConstants.CONSULTATION}/$consultationId');

    return response.code;
  }

  Future<int?> confirmConsultation({required String consultationId}) async {
    final response = await post(
        '${ApiConstants.CONSULTATION_DOCTOR}/$consultationId',
        isDoctor: true);

    return response.code;
  }

  Future<int?> deleteConsultation({required String consultationId}) async {
    final response = await delete(
        '${ApiConstants.CONSULTATION_DOCTOR}/$consultationId',
        isDoctor: true);

    return response.code;
  }

  Future<int?> createFeeback({required FeedbackRequest request}) async {
    final response =
        await post(ApiConstants.CONSULTATION_FEEDBACK, data: request.toJson());

    return response.code;
  }

  Future<List<FeedbackResponse>> fetchFeedbackDoctor(
      {required String doctorId}) async {
    final response = await get(
      '${ApiConstants.CONSULTATION_FEEDBACK}/$doctorId/doctor',
    );

    final List<dynamic> objects = json.decode(json.encode(response.data));
    final List<FeedbackResponse> feedbacks =
        objects.map((e) => FeedbackResponse.fromMap(e)).toList();
    return feedbacks;
  }

  Future<List<FeedbackResponse>> fetchFeedbackUser(
      {required String userId}) async {
    final response = await get(
      '${ApiConstants.CONSULTATION_FEEDBACK}/$userId/user',
    );

    final List<dynamic> objects = json.decode(json.encode(response.data));
    final List<FeedbackResponse> feedbacks =
        objects.map((e) => FeedbackResponse.fromMap(e)).toList();
    return feedbacks;
  }

  Future<ConsultationResponse> fetchDetailDoctorConsultation(
      {required String consultationId}) async {
    final response = await get(
        '${ApiConstants.CONSULTATION_DOCTOR_CONSULTATION}/$consultationId',
        isDoctor: true);
    ConsultationResponse res = response.data != null
        ? ConsultationResponse.fromMap(response.data)
        : ConsultationResponse();
    return res;
  }

  Future<List<UserResponse>> fetchPatient() async {
    final response =
        await get(ApiConstants.CONSULTATION_DOCTOR_INFORMATION, isDoctor: true);
    final List<dynamic> objects =
        json.decode(json.encode(response.data['consultation']));
    final List<UserResponse> patients =
        objects.map((e) => UserResponse.fromMap(e)).toList();
    return patients;
  }

  Future<AllConsultationResponse> fetchPatientConsultation() async {
    final response = await get(ApiConstants.CONSULTATION_USER);
    final List<dynamic> oComing =
        json.decode(json.encode(response.data['coming']));
    final List<dynamic> oFinish =
        json.decode(json.encode(response.data['finish']));
    final List<dynamic> oCancel =
        json.decode(json.encode(response.data['cancel']));
    final List<ConsultationResponse> coming =
        oComing.map((e) => ConsultationResponse.fromMap(e)).toList();
    final List<ConsultationResponse> finish =
        oFinish.map((e) => ConsultationResponse.fromMap(e)).toList();
    final List<ConsultationResponse> cancel =
        oCancel.map((e) => ConsultationResponse.fromMap(e)).toList();

    return AllConsultationResponse(
        coming: coming, finish: finish, cancel: cancel);
  }

  Future<AllConsultationResponse> fetchDoctorConsultation() async {
    final response =
        await get(ApiConstants.CONSULTATION_DOCTOR, isDoctor: true);
    final List<dynamic> oComing =
        json.decode(json.encode(response.data['coming']));
    final List<dynamic> oFinish =
        json.decode(json.encode(response.data['finish']));
    final List<dynamic> oCancel =
        json.decode(json.encode(response.data['cancel']));
    final List<ConsultationResponse> coming =
        oComing.map((e) => ConsultationResponse.fromMap(e)).toList();
    final List<ConsultationResponse> finish =
        oFinish.map((e) => ConsultationResponse.fromMap(e)).toList();
    final List<ConsultationResponse> cancel =
        oCancel.map((e) => ConsultationResponse.fromMap(e)).toList();

    return AllConsultationResponse(
        coming: coming, finish: finish, cancel: cancel);
  }
}
