import 'dart:convert';

import 'package:healthline/res/style.dart';

class UserResponse {
  String? id;
  String? fullName;
  String? dateOfBirth;
  String? gender;
  Relationship? relationship;
  String? avatar;
  String? address;
  bool? isMainProfile;
  UserResponse({
    this.id,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.relationship,
    this.avatar,
    this.address,
    this.isMainProfile,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (fullName != null) {
      result.addAll({'full_name': fullName});
    }
    if (dateOfBirth != null) {
      result.addAll({'date_of_birth': dateOfBirth});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (relationship != null) {
      result.addAll({'relationship': relationship!.name});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (isMainProfile != null) {
      result.addAll({'isMainProfile': isMainProfile});
    }

    return result;
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['id'],
      fullName: map['full_name'],
      dateOfBirth: map['date_of_birth'],
      gender: map['gender'],
      relationship:map['relationship']!=null?
          Relationship.values.firstWhere((e) => e.name == map['relationship']):null,
      avatar: map['avatar'],
      address: map['address'],
      isMainProfile: map['isMainProfile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));
}
