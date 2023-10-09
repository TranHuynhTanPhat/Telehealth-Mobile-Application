import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:healthline/utils/log_data.dart';

class Disease {
  final String disease;
  final bool isChild;
  final List<Vaccination> vaccinations;

  Disease({required this.disease, required this.isChild, required this.vaccinations});


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'disease': disease});
    result.addAll({'isChild': isChild});
    result.addAll({'vaccinations': vaccinations.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      disease: map['disease'] ?? '',
      isChild: map['isChild'] ?? false,
      vaccinations: List<Vaccination>.from(map['vaccinations']?.map((x) => Vaccination.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Disease.fromJson(String source) => Disease.fromMap(json.decode(source));
}

class Vaccination {
  int dose;
  String notice;
  bool required;
  String method;
  List<Schedule> schedule;
  Vaccination({
    required this.dose,
    required this.notice,
    required this.required,
    required this.method,
    required this.schedule,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'dose': dose});
    result.addAll({'notice': notice});
    result.addAll({'required': required});
    result.addAll({'method': method});
    result.addAll({'schedule': schedule.map((x) => x.toMap()).toList()});

    return result;
  }

  factory Vaccination.fromMap(Map<String, dynamic> map) {
    return Vaccination(
      dose: map['dose']?.toInt() ?? 0,
      notice: map['notice'] ?? '',
      required: map['required'] ?? false,
      method: map['method'] ?? '',
      schedule:
          List<Schedule>.from(map['schedule']?.map((x) => Schedule.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vaccination.fromJson(String source) =>
      Vaccination.fromMap(json.decode(source));
}

class Schedule {
  int dose;
  String timeDose;
  String daysFromLastDose;
  Schedule({
    required this.dose,
    required this.timeDose,
    required this.daysFromLastDose,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'dose': dose});
    result.addAll({'timeDose': timeDose});
    result.addAll({'daysFromLastDose': daysFromLastDose});

    return result;
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      dose: map['dose']?.toInt() ?? 0,
      timeDose: map['timeDose'] ?? '',
      daysFromLastDose: map['daysFromLastDose'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source));
}

class VaccinationModel {
  Future<String> _fetchData() async {
    String jsonString =
        await rootBundle.loadString('assets/vaccination/vaccination.json');
    // print(jsonString);
    return jsonString;
  }

  Future<List<Disease>> fetchData() async {
    try {
      String jsonString = await _fetchData();
      List<dynamic> temp = json.decode(jsonString).toList();

      List<Disease> diseases = temp.map((element) {
        final Disease disease = Disease.fromMap(element);
        return disease;
      }).toList();

      return diseases;
    } catch (e) {
      logPrint(e);
      return [];
    }
  }
}
