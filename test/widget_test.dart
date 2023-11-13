// This is a basic Flutter widget test.

// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_local_variable

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

import 'package:healthline/app/healthline_app.dart';

class MockStorage extends Mock implements Storage {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  // await AppController.instance.init();

  test('Check ENV', () {
    var baseUrl = dotenv.env['BASE_URL'];
    var cloudinaryUrl = dotenv.env['CLOUDINARY_URL'];
    var cloudinaryApi = dotenv.env['CLOUDINARY_API'];
  });

  Storage storage;
  setUp(() {
    storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });
  testWidgets('My App', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
