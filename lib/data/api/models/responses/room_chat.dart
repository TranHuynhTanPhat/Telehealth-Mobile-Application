import 'dart:convert';

import 'package:healthline/data/api/models/responses/doctor_detail_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';

class RoomChat {
  String? id;
  List<String>? consultation;
  UserResponse? medical;
  DoctorDetailResponse? doctor;
  List<String>? members;
  List<bool>? isSeen;
  String? lastMessage;
  String? createdAt;
  RoomChat({
    this.id,
    this.consultation,
    this.medical,
    this.doctor,
    this.members,
    this.isSeen,
    this.lastMessage,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(consultation != null){
      result.addAll({'consultation': consultation});
    }
    if(medical != null){
      result.addAll({'medical': medical!.toMap()});
    }
    if(doctor != null){
      result.addAll({'doctor': doctor!.toMap()});
    }
    if(members != null){
      result.addAll({'members': members});
    }
    if(isSeen != null){
      result.addAll({'isSeen': isSeen});
    }
    if(lastMessage != null){
      result.addAll({'lastMessage': lastMessage});
    }
    if(createdAt != null){
      result.addAll({'createdAt': createdAt});
    }
  
    return result;
  }

  factory RoomChat.fromMap(Map<String, dynamic> map) {
    return RoomChat(
      id: map['id'],
      consultation: List<String>.from(map['consultation']),
      medical: map['medical'] != null ? UserResponse.fromMap(map['medical']) : null,
      doctor: map['doctor'] != null ? DoctorDetailResponse.fromMap(map['doctor']) : null,
      members: List<String>.from(map['members']),
      isSeen: List<bool>.from(map['isSeen']),
      lastMessage: map['lastMessage'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomChat.fromJson(String source) => RoomChat.fromMap(json.decode(source));
}
