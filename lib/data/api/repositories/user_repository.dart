// ignore_for_file: unused_field

import 'package:healthline/data/api/models/requests/login_request.dart';
import 'package:healthline/data/api/models/requests/signup_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/signup_response.dart';
import 'package:healthline/data/api/repositories/base_repository.dart';
import 'package:healthline/data/api/services/user_service.dart';

class UserRepository extends BaseRepository {
  final UserService _userService = UserService();

  Future<LoginResponse> login(String email, String password) async {
    LoginRequest request = LoginRequest(email: email, password: password);
    return await _userService.login(request);
  }

  Future<SignUpResponse> registerAccount(
      String fullName, String email, String password) async {
    SignUpRequest request =
        SignUpRequest(email: email, password: password, fullName: fullName);
    return await _userService.registerAccount(request);
  }
}
