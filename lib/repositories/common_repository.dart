// ignore_for_file: unused_field
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/services/common_service.dart';
import 'package:healthline/repositories/base_repository.dart';

class CommonRepository extends BaseRepository {
  final CommonService _commonService = CommonService();

  Future<LoginResponse> loginPatient(String phone, String password) async {
    UserRequest request = UserRequest(phone: phone, password: password);
    return await _commonService.loginPatient(request);
  }

  Future<void> refreshTokenPatient() async {
    await _commonService.refreshTokenPatient();
  }

  Future<void> refreshTokenDoctor() async {
    await _commonService.refreshTokenDoctor();
  }
  Future<LoginResponse> loginDoctor(String phone, String password) async {
    UserRequest request = UserRequest(phone: phone, password: password);
    return await _commonService.loginDoctor(request);
  }
}
