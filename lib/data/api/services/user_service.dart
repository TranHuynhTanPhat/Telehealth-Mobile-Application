import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/login_request.dart';
import 'package:healthline/data/api/models/requests/signup_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/signup_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class UserService extends BaseService {
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await post(LOG_IN, data: request.toJson());
    return LoginResponse.fromJson(response.data);
  }

  Future<SignUpResponse> registerAccount(SignUpRequest request) async {
    final response = await post(SIGN_UP, data: request.toJson());
    return SignUpResponse.fromJson(response.data);
  }
}