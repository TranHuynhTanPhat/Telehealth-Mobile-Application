import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/repositories/common_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../services/mock_services.dart';

class MockCommonRepository extends Mock implements CommonRepository {
  final MockCommonService _mockCommonService = MockCommonService();
  MockCommonRepository();
  @override
  Future<LoginResponse> loginDoctor(String phone, String password) async {
    return await _mockCommonService
        .loginDoctor(UserRequest(phone: phone, password: password));
  }
  @override
  Future<LoginResponse> loginPatient(String phone, String password) async {
    return await _mockCommonService
        .loginPatient(UserRequest(phone: phone, password: password));
  }


}
