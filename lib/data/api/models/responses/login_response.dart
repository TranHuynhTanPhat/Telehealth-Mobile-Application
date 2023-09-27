import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LoginResponse extends Equatable {
  String? id;
  String? jwtToken;

  LoginResponse({this.id, this.jwtToken});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (jwtToken != null) {
      result.addAll({'jwt_token': jwtToken});
    }

    return result;
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      id: map['id'],
      jwtToken: map['jwt_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));

  @override
  List<Object?> get props => [id, jwtToken];

  LoginResponse copyWith({
    String? id,
    String? jwtToken,
  }) {
    return LoginResponse(
      id: id ?? this.id,
      jwtToken: jwtToken ?? this.jwtToken,
    );
  }
}
