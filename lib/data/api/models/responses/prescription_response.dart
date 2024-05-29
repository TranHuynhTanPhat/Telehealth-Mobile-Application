import 'dart:convert';

class PrescriptionResponse {
  String? id;
  String? createdAt;
  String? patientName;
  String? patientAddress;
  String? gender;
  String? doctorName;
  String? diagnosis;
  List<DrugModal>? drugs;
  String? notice;
  PrescriptionResponse({
    this.id,
    this.createdAt,
    this.patientName,
    this.patientAddress,
    this.gender,
    this.doctorName,
    this.diagnosis,
    this.drugs,
    this.notice,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (patientName != null) {
      result.addAll({'patientName': patientName});
    }
    if (patientAddress != null) {
      result.addAll({'patientAddress': patientAddress});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (doctorName != null) {
      result.addAll({'doctorName': doctorName});
    }
    if (diagnosis != null) {
      result.addAll({'diagnosis': diagnosis});
    }
    if (drugs != null) {
      result.addAll({'drugs': drugs!.map((x) => x.toMap()).toList()});
    }
    if (notice != null) {
      result.addAll({'note': notice});
    }

    return result;
  }

  factory PrescriptionResponse.fromMap(Map<String, dynamic> map) {
    return PrescriptionResponse(
      id: map['id'],
      createdAt: map['created_at'],
      patientName: map['patientName'],
      patientAddress: map['patientAddress'],
      gender: map['gender'],
      doctorName: map['doctorName'],
      diagnosis: map['diagnosis'],
      drugs: map['drugs'] != null
          ? List<DrugModal>.from(map['drugs']?.map((x) => DrugModal.fromMap(x)))
          : [],
      notice: map['note'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrescriptionResponse.fromJson(String source) =>
      PrescriptionResponse.fromMap(json.decode(source));

  PrescriptionResponse copyWith({
    String? id,
    String? createdAt,
    String? patientName,
    String? patientAddress,
    String? gender,
    String? doctorName,
    String? diagnosis,
    List<DrugModal>? drugs,
    String? notice,
  }) {
    return PrescriptionResponse(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      patientName: patientName ?? this.patientName,
      patientAddress: patientAddress ?? this.patientAddress,
      gender: gender ?? this.gender,
      doctorName: doctorName ?? this.doctorName,
      diagnosis: diagnosis ?? this.diagnosis,
      drugs: drugs ?? this.drugs,
      notice: notice ?? this.notice,
    );
  }
}

class DrugModal {
  String? code;
  String? name;
  String? type;
  String? note;
  int? quantity;
  String? unit;
  DrugModal({
    this.code,
    this.name,
    this.type,
    this.note,
    this.quantity,
    this.unit,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(code != null){
      result.addAll({'code': code});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(type != null){
      result.addAll({'type': type});
    }
    if(note != null){
      result.addAll({'note': note});
    }
    if(quantity != null){
      result.addAll({'quantity': quantity});
    }
    if(unit != null){
      result.addAll({'unit': unit});
    }
  
    return result;
  }

  factory DrugModal.fromMap(Map<String, dynamic> map) {
    return DrugModal(
      code: map['code'],
      name: map['name'],
      type: map['type'],
      note: map['note'],
      quantity: map['quantity']?.toInt(),
      unit: map['unit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DrugModal.fromJson(String source) => DrugModal.fromMap(json.decode(source));

  DrugModal copyWith({
    String? code,
    String? name,
    String? type,
    String? note,
    int? quantity,
    String? unit,
  }) {
    return DrugModal(
      code: code ?? this.code,
      name: name ?? this.name,
      type: type ?? this.type,
      note: note ?? this.note,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }
}
