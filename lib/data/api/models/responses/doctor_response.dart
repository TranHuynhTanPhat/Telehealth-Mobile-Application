import 'dart:convert';

class DoctorResponse {
  String? id;
  String? avatar;
  String? name;
  String? specialty;
  double? averageRating;
  int? reviewed;
  DoctorResponse({
    this.id,
    this.avatar,
    this.name,
    this.specialty,
    this.averageRating,
    this.reviewed,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (specialty != null) {
      result.addAll({'specialty': specialty});
    }
    if (averageRating != null) {
      result.addAll({'averageRating': averageRating});
    }
    if (reviewed != null) {
      result.addAll({'reviewed': reviewed});
    }

    return result;
  }

  factory DoctorResponse.fromMap(Map<String, dynamic> map) {
    return DoctorResponse(
      id: map['id'],
      avatar: map['avatar'],
      name: map['name'],
      specialty: map['specialty'],
      averageRating: map['averageRating']?.toDouble(),
      reviewed: map['reviewed']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorResponse.fromJson(String source) =>
      DoctorResponse.fromMap(json.decode(source));
}
