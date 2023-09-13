// ignore_for_file: unused_field

import 'package:healthline/data/api/models/requests/login_request.dart';
import 'package:healthline/data/api/models/requests/signup_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/signup_response.dart';
import 'package:healthline/data/api/repositories/base_repository.dart';
import 'package:healthline/data/api/services/user_service.dart';

class UserRepository extends BaseRepository {
  final UserService _userService = UserService();

  Future<LoginResponse> login(String phone, String password) async {
    LoginRequest request = LoginRequest(phone: phone, password: password);
    return await _userService.login(request);
  }

  Future<SignUpResponse> registerAccount(
      String fullName, String phone, String password) async {
    SignUpRequest request =
        SignUpRequest(phone: phone, password: password, fullName: fullName);
    return await _userService.registerAccount(request);
  }

  Future<void> refreshToken() async {
    await _userService.refreshToken();
  }

  Future<void> logout() async{
    await _userService.logout();
  }
}
