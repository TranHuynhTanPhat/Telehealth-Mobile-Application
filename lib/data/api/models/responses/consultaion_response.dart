import 'dart:convert';

import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';

class ConsultationResponse {
  String? id;
  DoctorResponse? doctor;
  UserResponse? medical;
  String? date;
  String? expectedTime;
  int? price;
  String? status;
  String? updatedAt;

  ConsultationResponse(
      {this.id,
      this.doctor,
      this.medical,
      this.date,
      this.expectedTime,
      this.price,
      this.status,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (doctor != null) {
      result.addAll({'doctor': doctor!.toMap()});
    }
    if (medical != null) {
      result.addAll({'medical': medical!.toMap()});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (expectedTime != null) {
      result.addAll({'expected_time': expectedTime});
    }
    if (price != null) {
      result.addAll({'price': price});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (updatedAt != null) {
      result.addAll({'updated_at': updatedAt});
    }

    return result;
  }

  factory ConsultationResponse.fromMap(Map<String, dynamic> map) {
    return ConsultationResponse(
      id: map['id'],
      doctor:
          map['doctor'] != null ? DoctorResponse.fromMap(map['doctor']) : null,
      medical:
          map['medical'] != null ? UserResponse.fromMap(map['medical']) : null,
      date: map['date'],
      expectedTime: map['expected_time'],
      price: map['price']?.toInt(),
      status: map['status'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultationResponse.fromJson(String source) =>
      ConsultationResponse.fromMap(json.decode(source));
}
