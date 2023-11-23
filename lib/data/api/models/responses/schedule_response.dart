import 'dart:convert';

class ScheduleResponse {
  String? id;
  String? date;
  List<int?>? workingTimes;
  ScheduleResponse({
    this.id,
    this.date,
    this.workingTimes,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (workingTimes != null) {
      result.addAll({
        'working_times':  workingTimes!.join('-') 
      });
    }

    return result;
  }

  factory ScheduleResponse.fromMap(Map<String, dynamic> map) {
    return ScheduleResponse(
      id: map['id'],
      date: map['date'],
      workingTimes: map['working_times'].isEmpty
          ? []
          : map['working_times'] != null
              ? map['working_times'].toString().split('-').map<int?>((e) {
                  return int.tryParse(e);
                }).toList()
              : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleResponse.fromJson(String source) =>
      ScheduleResponse.fromMap(json.decode(source));
}
