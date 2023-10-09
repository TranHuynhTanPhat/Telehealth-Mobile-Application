import 'dart:convert';

import 'package:healthline/res/style.dart';

class HealthStatResponse {
  TypeHealthStat? type;
  int? value;
  String? unit;
  HealthStatResponse({
    this.type,
    this.value,
    this.unit,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (type != null) {
      result.addAll({'type': type ?? type?.name});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (unit != null) {
      result.addAll({'unit': unit});
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
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthStatResponse.fromJson(String source) =>
      HealthStatResponse.fromMap(json.decode(source));
}
