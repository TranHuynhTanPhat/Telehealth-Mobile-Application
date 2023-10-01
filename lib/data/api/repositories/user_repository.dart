// ignore_for_file: unused_field
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/api/repositories/base_repository.dart';
import 'package:healthline/data/api/services/user_service.dart';

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

  Future<int?> updateAccount(String fullName, String email, String gender,
      String birthday, String address, String avatar) async {
    UserRequest request = UserRequest(
        avatar: avatar,
        fullName: fullName,
        gender: gender,
        birthday: birthday,
        address: address,
        email: email);
    return await _userService.updateAccount(request);
  }

  Future<List<UserResponse>> fetchProfile() async{
    return await _userService.profile();
  }

  Future<void> refreshToken() async {
    await _userService.refreshToken();
  }

  // Future<void> logout() async {
  //   await _userService.logout();
  // }
}
