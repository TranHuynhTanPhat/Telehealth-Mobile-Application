import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/doctor_detail_response.dart';
import 'package:healthline/data/api/models/responses/spending_chart_patient.dart';
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
    final response = await patch(ApiConstants.USER_EMAIL, data: jsonRequest);
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
      {required String password, required String newPassword}) async {
    var jsonRequest = json.encode(
      {"password": password, "new_password": newPassword},
    );
    final response = await patch(ApiConstants.USER_PASSWORD, data: jsonRequest);

    return response.code;
  }

  Future<int?> sendOTP({required String email}) async {
    final response = await post(
      '${ApiConstants.USER_FORGOT_PASSWORD}/$email',
    );

    return response.code;
  }

  Future<int?> resetPassword(
      {required String email,
      required String otp,
      required String password,
      required String confirmPassword}) async {
    var jsonRequest = json.encode({
      "email": email,
      "otp": otp,
      "password": password,
      "passwordConfirm": confirmPassword
    });

    final response =
        await post(ApiConstants.USER_FORGOT_PASSWORD_RESET, data: jsonRequest);

    return response.code;
  }

  Future<int?> addWishList({required String doctorid}) async {
    var jsonRequest = json.encode(
      {"doctorId": doctorid},
    );

    final response = await post(ApiConstants.USER_WISH_LIST, data: jsonRequest);

    return response.code;
  }

  Future<List<DoctorDetailResponse>> getWishList() async {
    final response = await get(ApiConstants.USER_WISH_LIST);
    List<DoctorDetailResponse> doctorResponse = response.data
        .map<DoctorDetailResponse>((e) => DoctorDetailResponse.fromMap(e))
        .toList();
    return doctorResponse;
  }

  Future<SpendingChartPatient> fetchSpendingChart(
      {required String id, required int month, required int year}) async {
    final response = await get(
        "${ApiConstants.CONSULTATION_MEDICAL_CHART}/$id/$month/$year");
    SpendingChartPatient chart = SpendingChartPatient.fromMap(response.data);
    return chart;
  }
}
