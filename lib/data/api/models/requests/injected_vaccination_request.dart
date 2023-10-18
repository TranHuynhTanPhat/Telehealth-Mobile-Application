import 'dart:convert';

class InjectedVaccinationRequest {
  String? medicalRecord;
  String? recorId;
  String? vaccineId;
  int? doseNumber;
  String? date;
  InjectedVaccinationRequest({
    this.medicalRecord,
     this.vaccineId,
     this.doseNumber,
     this.date,
    this.recorId
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'record_id':recorId});
    result.addAll({'medical_record': medicalRecord});
    result.addAll({'vaccine_id': vaccineId});
    result.addAll({'dose_number': doseNumber});
    result.addAll({'date': date});

    return result;
  }

  factory InjectedVaccinationRequest.fromMap(Map<String, dynamic> map) {
    return InjectedVaccinationRequest(
      recorId: map['record_id'],
      medicalRecord: map['medical_record'],
      vaccineId: map['vaccine_id'] ,
      doseNumber: map['dose_number'].toInt() ,
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InjectedVaccinationRequest.fromJson(String source) =>
      InjectedVaccinationRequest.fromMap(json.decode(source));
}
