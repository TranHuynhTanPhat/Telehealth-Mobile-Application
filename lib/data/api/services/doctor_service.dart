import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/user_request.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class DoctorService extends BaseService {
  // Future<List<TopDoctorsResponse>> getDoctors() async {
  //   final response = await get(ApiConstants.DOCTOR_GET_PUBLIC);
  //   List<dynamic> doctors = response.data.toList();
  //   return doctors.map((e) => TopDoctorsResponse.fromMap(e)).toList();
  // }

  Future<LoginResponse> login(UserRequest request) async {
    final response =
        await post(ApiConstants.DOCTOR_LOG_IN, data: request.toJson());
    return LoginResponse.fromMap(response.data);
  }

  Future<List<ScheduleResponse>> getSchedule() async {
    final response = await get(ApiConstants.DOCTOR_SCHEDULE, isDoctor: true);
    List<ScheduleResponse> schedules = response.data
        .map<ScheduleResponse>((e) => ScheduleResponse.fromMap(e))
        .toList();
    return schedules;
  }

  Future<void> refreshToken() async {
    await post(baseUrl + ApiConstants.DOCTOR_REFRESH_TOKEN);
  }
}
