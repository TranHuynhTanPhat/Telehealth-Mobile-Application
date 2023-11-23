// This is a basic Flutter widget test.

// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_local_variable

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/healthline_app.dart';
import 'package:healthline/data/api/rpc_manager.dart';
import 'package:healthline/res/style.dart';

class MockStorage extends Mock implements Storage {}

// class MockLoginCubit extends MockCubit<LogInState> implements LogInCubit {}

// class MockLoginState extends Fake implements LogInCubit {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  // await AppController.instance.init();

  // final _homeCubit = HomeCubit();
  // final _vaccineRecordCubit = VaccineRecordCubit();
  // final _sideMenuCubit = SideMenuCubit();
  // final _medicalRecordCubit = MedicalRecordCubit();
  // final _contactCubit = ContactCubit();
  // final _vaccinationCubit = VaccinationCubit();
  // final _logInCubit = MockLoginCubit();
  // registerFallbackValue(MockLoginState());
  // when(() => _logInCubit.state).thenReturn(LogInInitial());
  // final _signUpCubit = SignUpCubit();
  // final _doctorScheduleCubit = DoctorScheduleCubit();
  // final _doctorProfileCubit = DoctorProfileCubit();
  // final _patientRecordCubit = PatientRecordCubit();

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
  RpcManager().init();
  testWidgets('My App', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(AppController().authState, AuthState.Unauthorized);
  });

  
}
