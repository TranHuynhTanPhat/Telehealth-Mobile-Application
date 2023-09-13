class SignUpResponse {
  String? fullName;
  String? phone;
  bool? notification;

  SignUpResponse({this.fullName, this.phone, this.notification});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phone = json['phone'];
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['notification'] = notification;
    return data;
  }
}
