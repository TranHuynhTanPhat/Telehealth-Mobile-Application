class SignUpResponse {
  String? fullName;
  String? email;
  bool? notification;

  SignUpResponse({this.fullName, this.email, this.notification});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['notification'] = notification;
    return data;
  }
}
