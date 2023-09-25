import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/login_request.dart';
import 'package:healthline/data/api/models/requests/signup_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/api/services/base_service.dart';

class UserService extends BaseService {
  ///
  Future<LoginResponse> login(LoginRequest request) async {
    final response =
        await post(ApiConstants.USER_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  Future<int?> registerAccount(SignUpRequest request) async {
    final response = await post(ApiConstants.USER, data: request.toJson());
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
