import 'dart:developer';

import 'package:healthline/data/api/models/responses/doctors_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class DoctorService extends BaseService{
  Future<DoctorsResponse> getDoctors () async {
    final response = await get("http://192.168.1.15:3003/doctor-management/doctor");
    print(response);
    log("NEXT");
    print(response.data);
    
    return DoctorsResponse.fromJson(response.data);
  }
}