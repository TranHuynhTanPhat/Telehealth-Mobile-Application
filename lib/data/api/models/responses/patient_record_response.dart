import 'dart:convert';

class PatientRecordResponse {
  String? id;
  String? record;
  String? folder;
  String? size;
  String? updateAt;
  PatientRecordResponse({
    this.id,
    this.record,
    this.updateAt,
    this.folder,
    this.size,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (record != null) {
      result.addAll({'record': record});
    }
    if (folder != null) {
      result.addAll({'folder': folder});
    }
    if (size != null) {
      result.addAll({'size': size});
    }
    if (updateAt != null) {
      result.addAll({'update_at': updateAt});
    }

    return result;
  }

  factory PatientRecordResponse.fromMap(Map<String, dynamic> map) {
    return PatientRecordResponse(
      id: map['id'],
      record: map['record'],
      folder: map['folder'],
      size: map['size'],
      updateAt: map['update_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientRecordResponse.fromJson(String source) =>
      PatientRecordResponse.fromMap(json.decode(source));
}
