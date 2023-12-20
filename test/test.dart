// ignore_for_file: unused_local_variable

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:mocktail/mocktail.dart';

import 'services/common_service_test.dart';

void main() async {
  await dotenv.load();

  test('Check ENV', () {
    var baseUrl = dotenv.env['BASE_URL'];
    var cloudinaryUrl = dotenv.env['CLOUDINARY_URL'];
    var socketURL = dotenv.env['SOCKET_URL'];
  });

  late MockCommonService mockCommonService;
  setUp(() {
    mockCommonService = MockCommonService();
  });

  group("common service test", () {
    test("check login patient", () async {
      when(() => mockCommonService.loginPatient(UserRequest(phone: "+84389052819",password: "Phat@123"))).thenAnswer(
          (_) async => LoginResponse(id: null, jwtToken: ""));
    
      // expect(eitherResult, isA<PostModal>());
      // expect(sut.state, NotifierState.loaded);
    });
  });
}
