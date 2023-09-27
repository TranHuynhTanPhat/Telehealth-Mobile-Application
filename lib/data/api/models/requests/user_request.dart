class UserRequest {
  String? avatar;
  String? phone;
  String? password;
  String? passwordConfirm;
  String? fullName;
  String? gender;
  String? birthday;
  String? address;
  String? email;
  UserRequest(
      {this.phone,
      this.avatar,
      this.password,
      this.passwordConfirm,
      this.fullName,
      this.gender,
      this.birthday,
      this.address,
      this.email});

  UserRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    avatar = json['avatar'];
    password = json['password'];
    fullName = json['full_name'];
    birthday = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
    passwordConfirm = json['passwordConfirm'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['password'] = password;
    data['passwordConfirm'] = passwordConfirm;
    data['full_name'] = fullName;
    data['gender'] = gender;
    data['date_of_birth'] = birthday;
    data['address'] = address;
    data['email'] = email;
    return data;
  }
}
