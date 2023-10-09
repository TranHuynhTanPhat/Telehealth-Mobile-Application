import 'dart:convert';

class VaccinationResponse {
  String? id;
  String? disease;
  int? maxDose;
  bool? isChild;
  VaccinationResponse({
    this.id,
    this.disease,
    this.maxDose,
    this.isChild,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (disease != null) {
      result.addAll({'disease': disease});
    }
    if (maxDose != null) {
      result.addAll({'max_dose': maxDose});
    }
    if (isChild != null) {
      result.addAll({'is_child': isChild});
    }

    return result;
  }

  factory VaccinationResponse.fromMap(Map<String, dynamic> map) {
    return VaccinationResponse(
      id: map['id'],
      disease: map['disease'],
      maxDose: map['max_dose']?.toInt(),
      isChild: map['is_child'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VaccinationResponse.fromJson(String source) =>
      VaccinationResponse.fromMap(json.decode(source));
}
