// ignore_for_file: unused_local_variable

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:healthline/data/api/models/responses/login_response.dart';

import 'repositories/mock_common_repositories.dart';
import 'services/mock_services.dart';

void main() {
  setUp(() async {
    await dotenv.load();
  });

  test('Check ENV', () {
    var baseUrl = dotenv.env['BASE_URL'];
    var cloudinaryUrl = dotenv.env['CLOUDINARY_URL'];
    var socketURL = dotenv.env['SOCKET_URL'];
    expect(baseUrl, isNotNull);
    expect(cloudinaryUrl, isNotNull);
    expect(socketURL, isNotNull);
  });

  group("common service test", () {
    late MockCommonRepository mockCommonRepository;
    late MockCommonService mockCommonService;
    setUp(() {
      mockCommonRepository = MockCommonRepository();
      mockCommonService = MockCommonService();
    });
    test("check login patient", () async {
      final result = await mockCommonRepository.loginPatient(
           "+84389052819","Phat123!");
      expect(
          result,
          LoginResponse(
              id: "FlO644I14hwa-Hdh1VW_3",
              jwtToken:
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZSI6Iis4NDM4OTA1MjgxOSIsImlkIjoiRmxPNjQ0STE0aHdhLUhkaDFWV18zIiwiaWF0IjoxNzAzMTMxNDE4LCJleHAiOjE3MDM0NzcwMTh9.FQcPrZ9pelB2deOqvlkTjQXJTQbNi15Y4Y7u3tndBJ8"));
      // expect(sut.state, NotifierState.loaded);
    });
  });
}
