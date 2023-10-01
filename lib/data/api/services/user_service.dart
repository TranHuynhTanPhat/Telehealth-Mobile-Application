import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
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

  Future<int?> updateAccount(UserRequest request) async {
    var jsonRequest = json.encode({
      "avatar": request.avatar,
      "full_name": request.fullName,
      "email": request.email,
      "date_of_birth": request.birthday,
      "address": request.address,
      "gender": request.gender
    });
    final response = await patch(ApiConstants.USER, data: jsonRequest);
    return response.code;
  }
  Future<int?> profile() async {
    final response = await get(ApiConstants.PROFILE);
    return response.code;
  }

  Future<void> refreshToken() async {
    await post(baseUrl + ApiConstants.USER_REFRESH_TOKEN);
  }

  Future<void> logout() async {
    RestClient().logout();
    await delete(baseUrl + ApiConstants.USER_LOG_OUT);
  }
}
