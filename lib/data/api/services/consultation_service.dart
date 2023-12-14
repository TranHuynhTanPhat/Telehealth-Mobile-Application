import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/api/services/base_service.dart';

class ConsultationService extends BaseService {
  Future<List<int>> fetchTimeline(
      {required String id, required String date}) async {
    final response = await post(
        '${ApiConstants.CONSULTATION_DOCTOR_SCHEDULE}/$id/schedule',
        data: jsonEncode({'date': date}));
    List<int> timeline = response.data.map<int>((e) => e);
    return timeline;
  }

  Future<void> refreshTokenPatient() async {
    await post(baseUrl + ApiConstants.USER_REFRESH_TOKEN);
  }

  Future<void> logoutPatient() async {
    RestClient().logout();
    await delete(baseUrl + ApiConstants.USER_LOG_OUT);
  }

  Future<LoginResponse> loginDoctor(UserRequest request) async {
    final response =
        await post(ApiConstants.DOCTOR_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  Future<void> refreshTokenDoctor() async {
    await post(baseUrl + ApiConstants.DOCTOR_REFRESH_TOKEN);
  }
}
