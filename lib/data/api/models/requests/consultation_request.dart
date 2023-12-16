import 'dart:convert';

class ConsultationRequest {
  String? doctorId;
  String? medicalRecord;
  String? date;
  String? expectedTime;
  int? price;
  String? discountCode;

  ConsultationRequest(
      {this.doctorId,
      this.medicalRecord,
      this.date,
      this.expectedTime,
      this.price,
      this.discountCode});

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
  }) {
    return ConsultationRequest(
      doctorId: doctorId ?? this.doctorId,
      medicalRecord: medicalRecord ?? this.medicalRecord,
      date: date ?? this.date,
      expectedTime: expectedTime ?? this.expectedTime,
      price: price ?? this.price,
      discountCode: discountCode ?? this.discountCode,
    );
  }
}
