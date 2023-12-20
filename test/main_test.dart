// ignore_for_file: unused_local_variable

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:healthline/data/api/models/responses/login_response.dart';

import 'repositories/mock_common_repositories.dart';

void main() {
  setUp(() async {
    await dotenv.load();
  });

  test('Check ENV', () {
    var baseUrl = dotenv.env['BASE_URL'];
    var cloudinaryUrl = dotenv.env['CLOUDINARY_URL'];
    var socketURL = dotenv.env['SOCKET_URL'];
    expect(baseUrl, isNotNull);
  });

  late MockCommonRepository mockCommonRepository;
  setUp(() {
    mockCommonRepository = MockCommonRepository();
  });

  group("common service test", () {
    test("check login patient", () async {
      when(() => mockCommonRepository.loginDoctor("+84389052819", "Phat123!"))
          .thenAnswer((_) async => LoginResponse(id: null, jwtToken: ""));

      LoginResponse result =
          await mockCommonRepository.loginDoctor("+84389052819", "Phat123!");
      expect(result, LoginResponse(id: null, jwtToken: ""));
      // expect(sut.state, NotifierState.loaded);
    });
  });
}
