import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class UserService extends BaseService {
  Future<int?> registerAccount(UserRequest request) async {
    final response = await post(ApiConstants.USER, data: request.toJson());
    return response.code;
  }

  Future<int?> addMedicalRecord(UserRequest request) async {
    final response =
        await post(ApiConstants.USER_MEDICAL_RECORD, data: request.toJson());
    return response.code;
  }

  Future<DataResponse> updateMedicalRecord(UserRequest request) async {
    final response =
        await patch(ApiConstants.USER_MEDICAL_RECORD, data: request.toJson());
    return response;
  }

  Future<DataResponse> deleteMedicalRecord(String recordId) async {
    final response =
        await delete('${ApiConstants.USER_MEDICAL_RECORD}/$recordId');
    return response;
  }

  Future<DataResponse> updateEmail(String email) async {
    var jsonRequest = json.encode({
      "email": email,
    });
    final response = await patch(ApiConstants.USER, data: jsonRequest);
    return response;
  }

  Future<UserResponse> getProfile() async {
    final response = await get(ApiConstants.USER);
    return UserResponse.fromMap(response.data);
  }

  Future<List<UserResponse>> getMedicalRecord() async {
    final response = await get(ApiConstants.USER_MEDICAL_RECORD);
    List<UserResponse> userResponse = response.data
        .map<UserResponse>((e) => UserResponse.fromMap(e))
        .toList();
    return userResponse;
  }

  Future<int?> changePassword(
      {required String password, required String passwordConfirm}) async {
    final response = await patch(
      ApiConstants.USER_PASSWORD,
      data: json.encode(
        {"password": password, "passwordConfirm": passwordConfirm},
      ),
    );

    return response.code;
  }
}
