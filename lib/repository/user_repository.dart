// ignore_for_file: unused_field
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/repository/base_repository.dart';
import 'package:healthline/data/api/services/user_service.dart';
import 'package:healthline/res/enum.dart';

class UserRepository extends BaseRepository {
  final UserService _userService = UserService();

  Future<LoginResponse> login(String phone, String password) async {
    UserRequest request = UserRequest(phone: phone, password: password);
    return await _userService.login(request);
  }

  Future<int?> registerAccount(
      String fullName,
      String phone,
      String email,
      String password,
      String passwordConfirm,
      String gender,
      String birthday,
      String address) async {
    UserRequest request = UserRequest(
        phone: phone,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        fullName: fullName,
        gender: gender,
        birthday: birthday,
        address: address);
    return await _userService.registerAccount(request);
  }

  Future<DataResponse> addSubUser(
      String avatar,
      String fullName,
      String birthday,
      String gender,
      String relationship,
      String address) async {
    UserRequest request = UserRequest(
        avatar: avatar,
        fullName: fullName,
        gender: gender,
        birthday: birthday,
        relationship:
            Relationship.values.firstWhere((e) => e.name == relationship),
        address: address);
    return await _userService.addSubUser(request);
  }

  Future<DataResponse> updateSubUser(
      String profileId,
      String avatar,
      String fullName,
      String birthday,
      String gender,
      String relationship,
      String address) async {
    UserRequest request = UserRequest(
        profileId: profileId,
        avatar: avatar,
        fullName: fullName,
        gender: gender,
        birthday: birthday,
        relationship:
            Relationship.values.firstWhere((e) => e.name == relationship),
        address: address);
    return await _userService.updateSubUser(request);
  }

  Future<DataResponse> updateEmail(String email) async {
    return await _userService.updateEmail(email);
  }

  Future<UserResponse> fetchContact() async {
    return await _userService.getContact();
  }

  Future<List<UserResponse>> fetchMdicalRecord() async {
    return await _userService.getMedicalRecord();
  }

  Future<void> refreshToken() async {
    await _userService.refreshToken();
  }

  // Future<void> logout() async {
  //   await _userService.logout();
  // }
}
