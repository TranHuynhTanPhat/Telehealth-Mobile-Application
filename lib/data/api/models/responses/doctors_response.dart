import 'dart:convert';

import 'package:healthline/data/api/models/responses/doctor_response.dart';

class DoctorsResponse {
  List<DoctorResponse> data;
  DoctorsResponse({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'data': data.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory DoctorsResponse.fromMap(Map<String, dynamic> map) {
    return DoctorsResponse(
      data: List<DoctorResponse>.from(map['data']?.map((x) => DoctorResponse.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorsResponse.fromJson(String source) => DoctorsResponse.fromMap(json.decode(source));
}
