class SignUpRequest {
  String? phone;
  String? password;
  String? passwordConfirm;
  String? fullName;
  String? gender;
  String? birthday;
  String? address;
  SignUpRequest(
      {this.phone,
      this.password,
      this.passwordConfirm,
      this.fullName,
      this.gender,
      this.birthday,
      this.address});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    fullName = json['full_name'];
    birthday = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
    passwordConfirm = json['passwordConfirm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['passwordConfirm'] = passwordConfirm;
    data['full_name'] = fullName;
    data['gender'] = gender;
    data['date_of_birth'] = birthday;
    data['address'] = address;
    return data;
  }
}
