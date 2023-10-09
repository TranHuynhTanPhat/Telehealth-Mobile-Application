import 'dart:convert';

class InjectedVaccinationRequest {
  String medicalRecord;
  String vaccineId;
  int doseNumber;
  String date;
  InjectedVaccinationRequest({
    required this.medicalRecord,
    required this.vaccineId,
    required this.doseNumber,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'medical_record': medicalRecord});
    result.addAll({'vaccine_id': vaccineId});
    result.addAll({'dose_number': doseNumber});
    result.addAll({'date': date});

    return result;
  }

  factory InjectedVaccinationRequest.fromMap(Map<String, dynamic> map) {
    return InjectedVaccinationRequest(
      medicalRecord: map['medical_record'] ?? '',
      vaccineId: map['vaccine_id'] ?? '',
      doseNumber: map['dose_number'].toInt() ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InjectedVaccinationRequest.fromJson(String source) =>
      InjectedVaccinationRequest.fromMap(json.decode(source));
}
