import 'dart:convert';

import 'package:healthline/res/enum.dart';

class UserRequest {
  String? profileId;
  String? avatar;
  String? phone;
  String? password;
  String? passwordConfirm;
  String? fullName;
  String? gender;
  String? birthday;
  String? address;
  String? email;
  Relationship? relationship;
  UserRequest({
    this.profileId,
    this.avatar,
    this.phone,
    this.password,
    this.passwordConfirm,
    this.fullName,
    this.gender,
    this.birthday,
    this.address,
    this.email,
    this.relationship,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (profileId != null) {
      result.addAll({'profileId': profileId});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (passwordConfirm != null) {
      result.addAll({'passwordConfirm': passwordConfirm});
    }
    if (fullName != null) {
      result.addAll({'full_name': fullName});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (birthday != null) {
      result.addAll({'date_of_birth': birthday});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (relationship != null) {
      result.addAll({'relationship': relationship!.name});
    }

    return result;
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      profileId: map['profileId'],
      avatar: map['avatar'],
      phone: map['phone'],
      password: map['password'],
      passwordConfirm: map['passwordConfirm'],
      fullName: map['full_name'],
      gender: map['gender'],
      birthday: map['date_of_birth'],
      address: map['address'],
      email: map['email'],
      relationship: map['relationship'] != null
          ? Relationship.values.firstWhere((e) => e.name == map['relationship'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) =>
      UserRequest.fromMap(json.decode(source));
}
