import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
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
import 'package:healthline/data/api/services/base_service.dart';

class ConsultationService extends BaseService {
  Future<DiscountResponse> checkDiscount({required String code}) async {
    final response = await get("${ApiConstants.CONSULTATION_DISCOUNT}/$code");
    return DiscountResponse.fromMap(response.data);
  }

  Future<List<UserResponse>> getFamiliarCustomer(
      {required bool isDoctor}) async {
    final response = await get(
        ApiConstants.CONSULTATION_DOCTOR_FAMILIAR_CUSTOMER,
        isDoctor: isDoctor);
    final List<dynamic> objects = json.decode(json.encode(response.data));
    final List<UserResponse> users =
        objects.map((e) => UserResponse.fromMap(e)).toList();
    return users;
  }

  Future<List<UserResponse>> getNewCustomer({required bool isDoctor}) async {
    final response = await get(ApiConstants.CONSULTATION_DOCTOR_NEW_CUSTOMER,
        isDoctor: isDoctor);
    final List<dynamic> objects = json.decode(json.encode(response.data));
    final List<UserResponse> users =
        objects.map((e) => UserResponse.fromMap(e)).toList();
    return users;
  }

  Future<StatisticResponse> fetchStatisticTable(
      {required bool isDoctor}) async {
    final response = await get(ApiConstants.CONSULTATION_DOCTOR_STATISTIC_TABLE,
        isDoctor: isDoctor);
    return StatisticResponse.fromMap(response.data);
  }

  Future<MoneyChartResponse> moneyChart(
      {required int year, required bool isDoctor}) async {
    final response = await get(
        "${ApiConstants.CONSULTATION_DOCTOR_MONEY_CHART}/$year",
        isDoctor: isDoctor);
    return MoneyChartResponse.fromMap(response.data);
  }

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

  Future<PrescriptionResponse> fetchPrescription(
      {required String consultationId, required bool isDoctor}) async {
    final response = await get(
        '${ApiConstants.CONSULTATION_PRESCRIPTION}/$consultationId',
        isDoctor: true);
    PrescriptionResponse pre = PrescriptionResponse.fromMap(response.data);
    return pre;
  }

  Future<List<DrugResponse>> searchDrug(
      {required String key, required int pageKey}) async {
    final response = await get(
        "https://drugbank.vn/services/drugbank/api/public/thuoc",
        params: {"page": pageKey, "tenThuoc": key, "size": 20});

    final List<dynamic> objects = json.decode(json.encode(response.data));
    List<DrugResponse> drugs =
        objects.map((e) => DrugResponse.fromMap(e)).toList();

    return drugs;
  }

  Future<int?> createPrescription(
      {required PrescriptionResponse prescriptionResponse,
      required String consultationId}) async {
    final response = await post(
        "${ApiConstants.CONSULTATION_PRESCRIPTION}/$consultationId",
        data: prescriptionResponse.toJson());
    return response.code;
  }

  Future<List<DiscountResponse>> fetchDiscount() async {
    final response = await get(
      ApiConstants.CONSULTATION_DISCOUNT,
    );
    List<dynamic> objects = json.decode(json.encode(response.data));
    List<DiscountResponse> discounts =
        objects.map((e) => DiscountResponse.fromMap(e)).toList();
    return discounts;
  }

  Future<int?> announceBusy({required String consultationId}) async {
    final response =
        await delete("${ApiConstants.CONSULTATION_CONFIRM}/$consultationId");
    return response.code;
  }

  Future<DrugResponse> getInfoDrug({required String id}) async {
    final response = await get(
      "https://drugbank.vn/services/drugbank/api/public/thuoc?id=$id",
    );

    return DrugResponse.fromMap(response.data[0]);
  }
}
