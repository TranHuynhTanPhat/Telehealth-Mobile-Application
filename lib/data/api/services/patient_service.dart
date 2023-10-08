
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class PatientService extends BaseService {
  ///
  Future<LoginResponse> login(UserRequest request) async {
    final response =
        await post(ApiConstants.USER_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  
}
