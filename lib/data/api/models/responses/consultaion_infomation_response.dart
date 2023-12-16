import 'dart:convert';

class ConsultationInformationResponse {
  final String? medicalId;
  final String? phone;
  final String? email;
  ConsultationInformationResponse({
    this.medicalId,
    this.phone,
    this.email,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(medicalId != null){
      result.addAll({'medical_id': medicalId});
    }
    if(phone != null){
      result.addAll({'phone': phone});
    }
    if(email != null){
      result.addAll({'email': email});
    }
  
    return result;
  }

  factory ConsultationInformationResponse.fromMap(Map<String, dynamic> map) {
    return ConsultationInformationResponse(
      medicalId: map['medical_id'],
      phone: map['phone'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultationInformationResponse.fromJson(String source) => ConsultationInformationResponse.fromMap(json.decode(source));
}
