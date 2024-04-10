import 'dart:convert';

class ConsultationNotificationModel {
  String id;
  String time;
  String? doctorName;
  String? symptom;
  String? medicalHistory;
  String? payload;
  String? channelName;
  String? channelId;
  bool checked;
  ConsultationNotificationModel({
    required this.id,
    required this.time,
    this.doctorName,
    this.symptom,
    this.medicalHistory,
    this.payload,
    this.channelName,
    this.channelId,
     this.checked=false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'time': time});
    if (doctorName != null) {
      result.addAll({'doctor_name': doctorName});
    }
    if (symptom != null) {
      result.addAll({'symptom': symptom});
    }
    if (medicalHistory != null) {
      result.addAll({'medical_history': medicalHistory});
    }
    if (payload != null) {
      result.addAll({'payload': payload});
    }
    // if(channelName != null){
    //   result.addAll({'channelName': channelName});
    // }
    // if(channelId != null){
    //   result.addAll({'channelId': channelId});
    // }
    result.addAll({'checked': checked == true ? 1 : 0});

    return result;
  }

  factory ConsultationNotificationModel.fromMap(Map<String, dynamic> map) {
    return ConsultationNotificationModel(
      id: map['id'] ?? '',
      time: map['time'] ?? '',
      doctorName: map['doctor_name'],
      symptom: map['symptom'],
      medicalHistory: map['medical_history'],
      payload: map['payload'],
      channelName: map['channelName'],
      channelId: map['channelId'],
      checked: map['checked'] == 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsultationNotificationModel.fromJson(String source) =>
      ConsultationNotificationModel.fromMap(json.decode(source));

  ConsultationNotificationModel copyWith({
    String? id,
    String? time,
    String? doctorName,
    String? symptom,
    String? medicalHistory,
    String? payload,
    String? channelName,
    String? channelId,
    bool? checked,
  }) {
    return ConsultationNotificationModel(
      id: id ?? this.id,
      time: time ?? this.time,
      doctorName: doctorName ?? this.doctorName,
      symptom: symptom ?? this.symptom,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      payload: payload ?? this.payload,
      channelName: channelName ?? this.channelName,
      channelId: channelId ?? this.channelId,
      checked: checked ?? this.checked,
    );
  }
}
