import 'dart:convert';

class DoctorResponse {
  String? id;
  String? specialty;
  String? fullName;
  String? avatar;

  DoctorResponse({this.id, this.specialty, this.fullName, this.avatar});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (specialty != null) {
      result.addAll({'specialty': specialty});
    }
    if (fullName != null) {
      result.addAll({'fullName': fullName});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }

    return result;
  }

  factory DoctorResponse.fromMap(Map<String, dynamic> map) {
    return DoctorResponse(
      id: map['id'],
      specialty: map['specialty'],
      fullName: map['fullName'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorResponse.fromJson(String source) =>
      DoctorResponse.fromMap(json.decode(source));
}
