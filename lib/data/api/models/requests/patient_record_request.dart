import 'dart:convert';

class PatientRecordRequest {
  String? medicalId;
  String? record;
  String? folder;
  String? size;
  PatientRecordRequest({
    this.medicalId,
    this.record,
    this.folder,
    this.size,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(medicalId != null){
      result.addAll({'medicalId': medicalId});
    }
    if(record != null){
      result.addAll({'record': record});
    }
    if(folder != null){
      result.addAll({'folder': folder});
    }
    if(size != null){
      result.addAll({'size': size});
    }
  
    return result;
  }

  factory PatientRecordRequest.fromMap(Map<String, dynamic> map) {
    return PatientRecordRequest(
      medicalId: map['medicalId'],
      record: map['record'],
      folder: map['folder'],
      size: map['size'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientRecordRequest.fromJson(String source) => PatientRecordRequest.fromMap(json.decode(source));
}
