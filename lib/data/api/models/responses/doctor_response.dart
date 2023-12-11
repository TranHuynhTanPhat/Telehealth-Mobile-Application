import 'dart:convert';

class DoctorResponse {
  String? id;
  String? phone;
  String? email;
  String? fullName;
  String? avatar;
  String? biography;
  String? specialty;
  int? accountBalance;
  int? experience;
  int? feePerMinutes;
  String? fixedTimes;
  String? createdAt;
  String? updatedAt;
  double? ratings;
  int? numberOfConsultation;
  DoctorResponse({
    this.id,
    this.phone,
    this.email,
    this.fullName,
    this.avatar,
    this.biography,
    this.specialty,
    this.accountBalance,
    this.experience,
    this.feePerMinutes,
    this.fixedTimes,
    this.createdAt,
    this.updatedAt,
    this.ratings,
    this.numberOfConsultation,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (fullName != null) {
      result.addAll({'full_name': fullName});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }
    if (biography != null) {
      result.addAll({'biography': biography});
    }
    if (specialty != null) {
      result.addAll({'specialty': specialty});
    }
    if (accountBalance != null) {
      result.addAll({'account_balance': accountBalance});
    }
    if (experience != null) {
      result.addAll({'experience': experience});
    }
    if (feePerMinutes != null) {
      result.addAll({'fee_per_minutes': feePerMinutes});
    }
    if (fixedTimes != null) {
      result.addAll({'fixed_times': fixedTimes});
    }
    if (createdAt != null) {
      result.addAll({'created_at': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updated_at': updatedAt});
    }
    if (ratings != null) {
      result.addAll({'ratings': ratings});
    }
    if (numberOfConsultation != null) {
      result.addAll({'number_of_consultation': numberOfConsultation});
    }

    return result;
  }

  factory DoctorResponse.fromMap(Map<String, dynamic> map) {
    return DoctorResponse(
      id: map['id'],
      phone: map['phone'],
      email: map['email'],
      fullName: map['full_name'],
      avatar: map['avatar'],
      biography: map['biography'],
      specialty: map['specialty'],
      accountBalance: map['account_balance'],
      experience: map['experience'],
      feePerMinutes: map['fee_per_minutes'],
      fixedTimes: map['fixed_times'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      ratings: double.tryParse(map['ratings'].toString()) ?? 0.0,
      numberOfConsultation: map['number_of_consultation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorResponse.fromJson(String source) =>
      DoctorResponse.fromMap(json.decode(source));

  DoctorResponse copyWith({
    String? id,
    String? phone,
    String? email,
    String? fullName,
    String? avatar,
    String? biography,
    String? specialty,
    int? accountBalance,
    int? experience,
    int? feePerMinutes,
    String? fixedTimes,
    String? createdAt,
    String? updatedAt,
    double? ratings,
    int? numberOfConsultation,
  }) {
    return DoctorResponse(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatar: avatar ?? this.avatar,
      biography: biography ?? this.biography,
      specialty: specialty ?? this.specialty,
      accountBalance: accountBalance ?? this.accountBalance,
      experience: experience ?? this.experience,
      feePerMinutes: feePerMinutes ?? this.feePerMinutes,
      fixedTimes: fixedTimes ?? this.fixedTimes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ratings: ratings ?? this.ratings,
      numberOfConsultation: numberOfConsultation ?? this.numberOfConsultation,
    );
  }
}
