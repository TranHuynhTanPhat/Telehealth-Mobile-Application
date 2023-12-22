import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/api/services/common_service.dart';
import 'package:mocktail/mocktail.dart';

class MockCommonService extends Mock implements CommonService {
  @override
  Future<LoginResponse> loginPatient(UserRequest request) async {
    when(() =>
        post(ApiConstants.USER_LOG_IN,
            data: request.toJson())).thenAnswer((_) async => DataResponse(
        data: json.decode(
            '{ "id": "FlO644I14hwa-Hdh1VW_3","jwt_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6Iis4NDM4OTA1MjgxOSIsImlkIjoiRmxPNjQ0STE0aHdhLUhkaDFWV18zIiwiaWF0IjoxNzAzMTMxNDE4LCJleHAiOjE3MDM0NzcwMTh9.FQcPrZ9pelB2deOqvlkTjQXJTQbNi15Y4Y7u3tndBJ8"}')));
    final response =
        await post(ApiConstants.USER_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  @override
  Future<void> refreshTokenPatient() async {
    when(() => post(ApiConstants.USER_REFRESH_TOKEN))
        .thenAnswer((_) async => DataResponse(code: 201));

    await post(ApiConstants.USER_REFRESH_TOKEN);
  }

  @override
  Future<void> logoutPatient() async {
    RestClient().logout();
    await delete(ApiConstants.USER_LOG_OUT);
  }

  @override
  Future<LoginResponse> loginDoctor(UserRequest request) async {
    final response =
        await post(ApiConstants.DOCTOR_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  @override
  Future<void> refreshTokenDoctor() async {
    await post(ApiConstants.DOCTOR_REFRESH_TOKEN);
  }
}
