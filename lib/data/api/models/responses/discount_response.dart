import 'dart:convert';

class DiscountResponse {
  String? id;
  String? code;
  int? value;
  String? type;
  String? expirationTime;
  DiscountResponse({
    this.id,
    this.code,
    this.value,
    this.type,
    this.expirationTime,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (expirationTime != null) {
      result.addAll({'expiration_time': expirationTime});
    }

    return result;
  }

  factory DiscountResponse.fromMap(Map<String, dynamic> map) {
    return DiscountResponse(
      id: map['id'],
      code: map['code'],
      value: map['value']?.toInt(),
      type: map['type'],
      expirationTime: map['expiration_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscountResponse.fromJson(String source) =>
      DiscountResponse.fromMap(json.decode(source));
}
