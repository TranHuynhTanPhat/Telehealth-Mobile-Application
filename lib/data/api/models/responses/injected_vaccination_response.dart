import 'dart:convert';

import 'package:healthline/data/api/models/responses/vaccination_response.dart';

class InjectedVaccinationResponse {
  String? id;
  int? doseNumber;
  String? date;
  String? updatedAt;
  VaccinationResponse? vaccine;
  InjectedVaccinationResponse({
    this.id,
    this.doseNumber,
    this.date,
    this.updatedAt,
    this.vaccine,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(doseNumber != null){
      result.addAll({'dose_number': doseNumber});
    }
    if(date != null){
      result.addAll({'date': date});
    }
    if(updatedAt != null){
      result.addAll({'updated_at': updatedAt});
    }
    if(vaccine != null){
      result.addAll({'vaccine': vaccine!.toMap()});
    }
  
    return result;
  }

  factory InjectedVaccinationResponse.fromMap(Map<String, dynamic> map) {
    return InjectedVaccinationResponse(
      id: map['id'],
      doseNumber: map['dose_number']?.toInt(),
      date: map['date'],
      updatedAt: map['updated_at'],
      vaccine: map['vaccine'] != null ? VaccinationResponse.fromMap(map['vaccine']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InjectedVaccinationResponse.fromJson(String source) => InjectedVaccinationResponse.fromMap(json.decode(source));
}
