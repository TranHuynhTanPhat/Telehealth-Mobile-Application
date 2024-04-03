import 'dart:convert';

class StatisticResponse {
  String? typeOfService;
  int? quantity;
  int? pending;
  int? confirmed;
  int? sales;
  int? finished;
  int? discount;
  int? denied;
  int? canceled;
  int? revenue;
  StatisticResponse({
    this.typeOfService,
    this.quantity,
    this.pending,
    this.confirmed,
    this.sales,
    this.finished,
    this.discount,
    this.denied,
    this.canceled,
    this.revenue,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (typeOfService != null) {
      result.addAll({'type_of_service': typeOfService});
    }
    if (quantity != null) {
      result.addAll({'quantity': quantity});
    }
    if (pending != null) {
      result.addAll({'pending': pending});
    }
    if (confirmed != null) {
      result.addAll({'confirmed': confirmed});
    }
    if (sales != null) {
      result.addAll({'sales': sales});
    }
    if (finished != null) {
      result.addAll({'finished': finished});
    }
    if (discount != null) {
      result.addAll({'discount': discount});
    }
    if (denied != null) {
      result.addAll({'denied': denied});
    }
    if (canceled != null) {
      result.addAll({'canceled': canceled});
    }
    if (revenue != null) {
      result.addAll({'revenue': revenue});
    }

    return result;
  }

  factory StatisticResponse.fromMap(Map<String, dynamic> map) {
    return StatisticResponse(
      typeOfService: map['type_of_service'],
      quantity: map['quantity']?.toInt(),
      pending: map['pending']?.toInt(),
      confirmed: map['confirmed']?.toInt(),
      sales: map['sales']?.toInt(),
      finished: map['finished']?.toInt(),
      discount: map['discount']?.toInt(),
      denied: map['denied']?.toInt(),
      canceled: map['canceled']?.toInt(),
      revenue: map['revenue']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticResponse.fromJson(String source) =>
      StatisticResponse.fromMap(json.decode(source));
}
