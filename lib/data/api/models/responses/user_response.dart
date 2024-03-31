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
  String? phone;
  String? email;
  int? accountBalance;
  int? point;
  // List<String>? wishList;
  UserResponse({
    this.id,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.relationship,
    this.avatar,
    this.address,
    this.isMainProfile,
    this.phone,
    this.email,
    this.accountBalance,
    this.point,
    // this.wishList,
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
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (accountBalance != null) {
      result.addAll({'account_balance': accountBalance});
    }
    if (point != null) {
      result.addAll({'point': point});
    }
    // if (wishList != null) {
    //   result.addAll({'wish_list': wishList});
    // }

    return result;
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['id'],
      fullName: map['full_name'],
      dateOfBirth: map['date_of_birth'],
      gender: map['gender'],
      relationship: map['relationship'] != null
          ? Relationship.values.firstWhere((e) => e.name == map['relationship'])
          : null,
      avatar: map['avatar'],
      address: map['address'],
      isMainProfile: map['isMainProfile'],
      email: map['email'],
      phone: map['phone'],
      accountBalance: map['account_balance'],
      point: map['point'],
      // wishList: List<String>.from(map['wish_list']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));

  UserResponse copyWith({
    String? id,
    String? fullName,
    String? dateOfBirth,
    String? gender,
    Relationship? relationship,
    String? avatar,
    String? address,
    bool? isMainProfile,
    String? phone,
    String? email,
    int? accountBalance,
    int? point,
    // List<String>? wishList,
  }) {
    return UserResponse(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      relationship: relationship ?? this.relationship,
      avatar: avatar ?? this.avatar,
      address: address ?? this.address,
      isMainProfile: isMainProfile ?? this.isMainProfile,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      accountBalance: accountBalance ?? this.accountBalance,
      point: point ?? this.point,
      // wishList: wishList ?? this.wishList
    );
  }
}
