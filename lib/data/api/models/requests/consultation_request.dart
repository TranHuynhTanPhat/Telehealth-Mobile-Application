import 'dart:convert';

class ConsultationRequest {
  String? doctorId;
  String? medicalRecord;
  String? date;
  String? expectedTime;
  int? price;
  String? discountCode;
  String? symptoms;
  String? medicalHistory;
  List<String>? patientRecords;

  ConsultationRequest(
      {this.doctorId,
      this.medicalRecord,
      this.date,
      this.expectedTime,
      this.price,
      this.discountCode,
      this.symptoms,
      this.medicalHistory,
      this.patientRecords});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (doctorId != null) {
      result.addAll({'doctor_id': doctorId});
    }
    if (medicalRecord != null) {
      result.addAll({'medical_record': medicalRecord});
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
    if (discountCode != null) {
      result.addAll({'discount_code': discountCode});
    }
    if (symptoms != null) {
      result.addAll({'symptoms': symptoms});
    }
    if (medicalHistory != null) {
      result.addAll({'medical_history': medicalHistory});
    }
    if (patientRecords != null) {
      result.addAll({'patient_records': patientRecords});
    }

    return result;
  }

  factory ConsultationRequest.fromMap(Map<String, dynamic> map) {
    return ConsultationRequest(
      doctorId: map['doctor_id'],
      medicalRecord: map['medical_record'],
      date: map['date'],
      expectedTime: map['expected_time'],
      price: map['price']?.toInt(),
      discountCode: map['discount_code'],
      symptoms: map['symptoms'],
      medicalHistory: map['medical_history'],
      patientRecords: map['patient_records'] != null
          ? List<String>.from(map['patient_records']?.map((x) => x))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultationRequest.fromJson(String source) =>
      ConsultationRequest.fromMap(json.decode(source));

  ConsultationRequest copyWith({
    String? doctorId,
    String? medicalRecord,
    String? date,
    String? expectedTime,
    int? price,
    String? discountCode,
    String? symptoms,
    String? medicalHistory,
    List<String>? patientRecords,
  }) {
    return ConsultationRequest(
      doctorId: doctorId ?? this.doctorId,
      medicalRecord: medicalRecord ?? this.medicalRecord,
      date: date ?? this.date,
      expectedTime: expectedTime ?? this.expectedTime,
      price: price ?? this.price,
      discountCode: discountCode ?? this.discountCode,
      symptoms: symptoms ?? this.symptoms,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      patientRecords: patientRecords ?? this.patientRecords,
    );
  }
}
