import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/data/api/services/base_service.dart';

class CommonService extends BaseService {
  Future<LoginResponse> loginPatient(UserRequest request) async {
    final response =
        await post(ApiConstants.USER_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  Future<void> refreshTokenPatient() async {
    await post(ApiConstants.USER_REFRESH_TOKEN);
  }

  Future<void> logoutPatient() async {
    RestClient().logout();
    await delete(ApiConstants.USER_LOG_OUT);
  }

  Future<LoginResponse> loginDoctor(UserRequest request) async {
    final response =
        await post(ApiConstants.DOCTOR_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  Future<void> refreshTokenDoctor() async {
    await post(ApiConstants.DOCTOR_REFRESH_TOKEN);
  }
}
