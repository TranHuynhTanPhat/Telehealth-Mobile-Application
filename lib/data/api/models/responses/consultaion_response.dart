import 'dart:convert';

import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
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
  String? jistiToken;
  String? symptoms;
  String? medicalHistory;
  FeedbackResponse? feedback;
  List<PatientRecordResponse>? patientRecords;

  ConsultationResponse(
      {this.id,
      this.doctor,
      this.medical,
      this.date,
      this.expectedTime,
      this.jistiToken,
      this.price,
      this.status,
      this.updatedAt,
      this.symptoms,
      this.medicalHistory,
      this.patientRecords, this.feedback});

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
    if (jistiToken != null) {
      result.addAll({'jisti_token': jistiToken});
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
    if (symptoms != null) {
      result.addAll({'symptoms': symptoms});
    }
    if (medicalHistory != null) {
      result.addAll({'medical_history': medicalHistory});
    }
    if (patientRecords != null) {
      result.addAll({'patient_records': patientRecords?.map((x) => x.toMap()).toList()});
    }
    if (feedback != null) {
      result.addAll({'feedback': feedback!.toMap()});
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
      feedback:
          map['feedback'] != null ? FeedbackResponse.fromMap(map['feedback']) : null,
      date: map['date'],
      expectedTime: map['expected_time'],
      jistiToken: map['jisti_token'],
      price: map['price']?.toInt(),
      status: map['status'],
      updatedAt: map['updated_at'],
      symptoms: map['symptoms'],
      medicalHistory: map['medical_history'],
      patientRecords: map['patient_records']!= null? List<PatientRecordResponse>.from(map['patient_records']?.map((x) => PatientRecordResponse.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultationResponse.fromJson(String source) =>
      ConsultationResponse.fromMap(json.decode(source));
}
