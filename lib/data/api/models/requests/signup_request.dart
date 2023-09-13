class SignUpRequest {
  String? phone;
  String? password;
  String? fullName;

  SignUpRequest({this.phone, this.password, this.fullName});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['full_name'] = fullName;
    return data;
  }
}
