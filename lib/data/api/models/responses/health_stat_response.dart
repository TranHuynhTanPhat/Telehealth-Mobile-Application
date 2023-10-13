import 'dart:convert';

import 'package:healthline/res/style.dart';

class HealthStatResponse {
  TypeHealthStat? type;
  int? value;
  String? unit;
  List<History>? history;
  HealthStatResponse({this.type, this.value, this.unit, this.history});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (type != null) {
      result.addAll({'type': type?.name});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (unit != null) {
      result.addAll({'unit': unit});
    }
    if (history != null) {
      result.addAll({'history': history!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory HealthStatResponse.fromMap(Map<String, dynamic> map) {
    return HealthStatResponse(
      type: map['type'] != null
          ? TypeHealthStat.values.firstWhere((e) => e.name == map['type'])
          : null,
      value: map['value']?.toInt(),
      unit: map['unit'],
      history: map['history'] != null ? List<History>.from(map['history']?.map((x) => History.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthStatResponse.fromJson(String source) =>
      HealthStatResponse.fromMap(json.decode(source));
}

class History {
  String? id;
  int? value;
  String? unit;
  String? updatedAt;
  History({
    this.id,
    this.value,
    this.unit,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (unit != null) {
      result.addAll({'unit': unit});
    }
    if (updatedAt != null) {
      result.addAll({'updated_at': updatedAt});
    }

    return result;
  }

  factory History.fromMap(Map<String, dynamic> map) {
    print(map);
    return History(
      id: map['id'],
      value: map['value']?.toInt(),
      unit: map['unit'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source));
}
