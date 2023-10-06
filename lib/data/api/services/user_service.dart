import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/api/services/base_service.dart';

class UserService extends BaseService {
  ///
  Future<LoginResponse> login(UserRequest request) async {
    final response =
        await post(ApiConstants.USER_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  Future<int?> registerAccount(UserRequest request) async {
    final response = await post(ApiConstants.USER, data: request.toJson());
    return response.code;
  }

  Future<DataResponse> addSubUser(UserRequest request) async {
    final response =
        await post(ApiConstants.MEDICAL_RECORD, data: request.toJson());
    return response;
  }

  Future<DataResponse> updateSubUser(UserRequest request) async {
    final response =
        await patch(ApiConstants.MEDICAL_RECORD, data: request.toJson());
    return response;
  }

  Future<DataResponse> deleteSubUser(String recordId) async {
    final response = await delete('${ApiConstants.MEDICAL_RECORD}/$recordId');
    return response;
  }

  Future<DataResponse> updateEmail(String email) async {
    var jsonRequest = json.encode({
      "email": email,
    });
    final response = await patch(ApiConstants.USER, data: jsonRequest);
    return response;
  }

  Future<UserResponse> getContact() async {
    final response = await get(ApiConstants.USER);
    return UserResponse.fromMap(response.data);
  }

  Future<List<UserResponse>> getMedicalRecord() async {
    final response = await get(ApiConstants.MEDICAL_RECORD);
    List<UserResponse> userResponse = response.data
        .map<UserResponse>((e) => UserResponse.fromMap(e))
        .toList();
    return userResponse;
  }

  Future<void> refreshToken() async {
    await post(baseUrl + ApiConstants.USER_REFRESH_TOKEN);
  }

  Future<void> logout() async {
    RestClient().logout();
    await delete(baseUrl + ApiConstants.USER_LOG_OUT);
  }
}
