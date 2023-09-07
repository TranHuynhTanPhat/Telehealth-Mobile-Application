class LoginResponse {
  String? id;
  String? role;
  String? jwtToken;

  LoginResponse({this.id, this.role, this.jwtToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    jwtToken = json['jwt_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['jwt_token'] = jwtToken;
    return data;
  }
}
