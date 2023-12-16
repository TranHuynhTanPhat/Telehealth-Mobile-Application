import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/responses/all_consultation_response.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class ConsultationService extends BaseService {
  Future<List<int>> fetchTimeline(
      {required String id, required String date}) async {
    final response = await post(
        '${ApiConstants.CONSULTATION_DOCTOR_SCHEDULE}/$id/schedule',
        data: jsonEncode({'date': date}));
    List<int> timeline = List<int>.from(response.data);

    return timeline;
  }

  Future<int?> createConsultation(
      {required ConsultationRequest request}) async {
    final response =
        await post(ApiConstants.CONSULTATION, data: request.toJson());

    return response.code;
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
}
