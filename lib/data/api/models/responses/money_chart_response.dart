import 'dart:convert';

class MoneyChartResponse {
  List<MoneyByMonth>? moneyByMonth;

  MoneyChartResponse({
    this.moneyByMonth,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (moneyByMonth != null) {
      result.addAll(
          {'moneyByMonth': moneyByMonth!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory MoneyChartResponse.fromMap(Map<String, dynamic> map) {
    return MoneyChartResponse(
      moneyByMonth: map['moneyByMonth'] != null
          ? List<MoneyByMonth>.from(
              map['moneyByMonth']?.map((x) => MoneyByMonth.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoneyChartResponse.fromJson(String source) =>
      MoneyChartResponse.fromMap(json.decode(source));
}

class MoneyByMonth {
  int? month;
  int? totalMoneyThisMonth;
  MoneyByMonth({
    this.month,
    this.totalMoneyThisMonth,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (month != null) {
      result.addAll({'month': month});
    }
    if (totalMoneyThisMonth != null) {
      result.addAll({'totalMoneyThisMonth': totalMoneyThisMonth});
    }

    return result;
  }

  factory MoneyByMonth.fromMap(Map<String, dynamic> map) {
    return MoneyByMonth(
      month: map['month']?.toInt(),
      totalMoneyThisMonth: map['totalMoneyThisMonth']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MoneyByMonth.fromJson(String source) =>
      MoneyByMonth.fromMap(json.decode(source));
}
