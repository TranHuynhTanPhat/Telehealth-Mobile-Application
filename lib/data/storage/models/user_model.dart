
// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  String? role;
  String? accessToken;
  User({
    required this.role,
    required this.accessToken,
  });
  
  @override
  List<Object?> get props => [role, accessToken];

  User copyWith({
    String? role,
    String? accessToken,
  }) {
    return User(
      role: role ?? this.role,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(role != null){
      result.addAll({'role': role});
    }
    if(accessToken != null){
      result.addAll({'accessToken': accessToken});
    }
  
    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      role: map['role'],
      accessToken: map['accessToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
