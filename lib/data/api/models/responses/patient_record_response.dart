import 'dart:convert';

class PatientRecordResponse {
  String? id;
  String? name;
  String? folderName;
  String? updateAt;
  PatientRecordResponse({
    this.id,
    this.name,
    this.updateAt,
    this.folderName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (folderName != null) {
      result.addAll({'folder_name': folderName});
    }
    if (updateAt != null) {
      result.addAll({'update_at': updateAt});
    }

    return result;
  }

  factory PatientRecordResponse.fromMap(Map<String, dynamic> map) {
    return PatientRecordResponse(
      id: map['id'],
      name: map['name'],
      folderName: map['folder_name'],
      updateAt: map['update_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientRecordResponse.fromJson(String source) =>
      PatientRecordResponse.fromMap(json.decode(source));
}
