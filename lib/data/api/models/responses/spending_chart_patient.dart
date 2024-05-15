import 'dart:convert';

class SpendingChartPatient {
  List<SpendingByMonth>? moneyChartOfMonth;
  int? consultation;
  SpendingChartPatient({
    this.moneyChartOfMonth,
    this.consultation,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (moneyChartOfMonth != null) {
      result.addAll({
        'moneyChartOfMonth': moneyChartOfMonth!.map((x) => x.toMap()).toList()
      });
    }
    if (consultation != null) {
      result.addAll({'consultation': consultation});
    }

    return result;
  }

  factory SpendingChartPatient.fromMap(Map<String, dynamic> map) {
    List<SpendingByMonth>? listMoney;
    if (map['moneyChartOfMonth'] != null) {
      listMoney = map['moneyChartOfMonth'].entries.map((e) {
        return SpendingByMonth(date: e.date, money: e.money);
      }).toList();
    }
    return SpendingChartPatient(
      moneyChartOfMonth: listMoney,
      consultation: map['consultation']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpendingChartPatient.fromJson(String source) =>
      SpendingChartPatient.fromMap(json.decode(source));
}

class SpendingByMonth {
  String? date;
  int? money;
  SpendingByMonth({
    this.date,
    this.money,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (date != null) {
      result.addAll({'date': date});
    }
    if (money != null) {
      result.addAll({'money': money});
    }

    return result;
  }

  factory SpendingByMonth.fromMap(Map<String, dynamic> map) {
    return SpendingByMonth(
      date: map['date'],
      money: map['money']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpendingByMonth.fromJson(String source) =>
      SpendingByMonth.fromMap(json.decode(source));
}
