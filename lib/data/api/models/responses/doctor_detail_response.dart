import 'dart:convert';

class DoctorDetailResponse {
  String? id;
  String? fullName;
  String? phone;
  String? gender;
  String? dayOfBirth;
  String? email;
  String? address;
  String? fixedTime;
  double? ratings;
  String? avatar;
  String? biography;
  int? feePerMinutes;
  int? accountBalance;
  int? numberOfConsultation;
  String? updatedAt;
  bool? isActive;

  List<EducationAndCertificationModelResponse>? educationAndCertifications;
  List<SpecialtyModelResponse>? specialties;
  List<CareerModelResponse>? careers;
  DoctorDetailResponse({
    this.id,
    this.fullName,
    this.phone,
    this.gender,
    this.dayOfBirth,
    this.email,
    this.address,
    this.fixedTime,
    this.ratings,
    this.avatar,
    this.biography,
    this.feePerMinutes,
    this.accountBalance,
    this.numberOfConsultation,
    this.updatedAt,
    this.educationAndCertifications,
    this.specialties,
    this.careers,
    this.isActive,
  });

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   if (fullName != null) {
  //     result.addAll({'full_name': fullName});
  //   }
  //   if (phone != null) {
  //     result.addAll({'phone': phone});
  //   }
  //   if (gender != null) {
  //     result.addAll({'gender': gender});
  //   }
  //   if (dayOfBirth != null) {
  //     result.addAll({'day_of_birth': dayOfBirth});
  //   }
  //   if (email != null) {
  //     result.addAll({'email': email});
  //   }
  //   if (address != null) {
  //     result.addAll({'address': address});
  //   }
  //   if (introduce != null) {
  //     result.addAll({'introduce': introduce});
  //   }
  //   if (educationAndCertifications != null) {
  //     result.addAll({
  //       'education_and_certifications':
  //           educationAndCertifications!.map((x) => x.toMap()).toList()
  //     });
  //   }
  //   if (specialties != null) {
  //     result
  //         .addAll({'specialties': specialties!.map((x) => x.toMap()).toList()});
  //   }
  //   if (careers != null) {
  //     result.addAll({'careers': careers!.map((x) => x.toMap()).toList()});
  //   }

  //   return result;
  // }

  // factory DoctorDetailResponse.fromMap(Map<String, dynamic> map) {
  //   return DoctorDetailResponse(
  //     fullName: map['full_name'],
  //     phone: map['phone'],
  //     gender: map['gender'],
  //     dayOfBirth: map['day_of_birth'],
  //     email: map['email'],
  //     address: map['address'],
  //     introduce: map['fixedTime'],
  //     educationAndCertifications: map['education_and_certifications'] != null
  //         ? List<EducationAndCertificationModelResponse>.from(
  //             map['education_and_certifications']
  //                 ?.map((x) => EducationAndCertificationModelResponse.fromMap(x)))
  //         : null,
  //     specialties: map['specialties'] != null
  //         ? List<SpecialtyModelResponse>.from(
  //             map['specialties']?.map((x) => SpecialtyModelResponse.fromMap(x)))
  //         : null,
  //     careers: map['careers'] != null
  //         ? List<CareerModelResponse>.from(
  //             map['careers']?.map((x) => CareerModelResponse.fromMap(x)))
  //         : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory DoctorDetailResponse.fromJson(String source) =>
  //     DoctorDetailResponse.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (fullName != null) {
      result.addAll({'full_name': fullName});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (gender != null) {
      result.addAll({'gender': gender == "Male"});
    }
    if (dayOfBirth != null) {
      result.addAll({'dayOfBirth': dayOfBirth});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (fixedTime != null) {
      result.addAll({'fixed_times': fixedTime});
    }
    if (ratings != null) {
      result.addAll({'ratings': ratings});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }
    if (biography != null) {
      result.addAll({'biography': biography});
    }
    if (feePerMinutes != null) {
      result.addAll({'fee_per_minutes': feePerMinutes});
    }
    if (accountBalance != null) {
      result.addAll({'account_balance': accountBalance});
    }
    if (numberOfConsultation != null) {
      result.addAll({'number_of_consultation': numberOfConsultation});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (educationAndCertifications != null) {
      result.addAll({
        'educationAndCertification':
            educationAndCertifications!.map((x) => x.toMap()).toList()
      });
    }
    if (specialties != null) {
      result.addAll({'specialty': specialties!.map((x) => x.toMap()).toList()});
    }
    if (careers != null) {
      result.addAll({'career': careers!.map((x) => x.toMap()).toList()});
    }
    if (isActive != null) {
      result.addAll({'is_active': isActive});
    }

    return result;
  }

  factory DoctorDetailResponse.fromMap(Map<String, dynamic> map) {
    return DoctorDetailResponse(
      id: map['id'],
      fullName: map['full_name'],
      phone: map['phone'],
      gender: map['gender'] == true ? "Male" : "Female",
      dayOfBirth: map['dayOfBirth'],
      email: map['email'],
      address: map['address'],
      fixedTime: map['fixed_times'],
      ratings: double.tryParse(map['ratings'].toString()) ?? 0.0,
      avatar: map['avatar'],
      biography: map['biography'],
      feePerMinutes: map['fee_per_minutes']?.toInt(),
      accountBalance: map['account_balance']?.toInt(),
      numberOfConsultation: map['number_of_consultation']?.toInt(),
      updatedAt: map['updatedAt'],
      isActive: map['is_active'],
      educationAndCertifications: map['educationAndCertification'] != null
          ? List<EducationAndCertificationModelResponse>.from(
              map['educationAndCertification']?.map(
                  (x) => EducationAndCertificationModelResponse.fromMap(x)))
          : [],
      specialties: map['specialty'] != null
          ? List<SpecialtyModelResponse>.from(
              map['specialty']?.map((x) => SpecialtyModelResponse.fromMap(x)))
          : [],
      careers: map['career'] != null
          ? List<CareerModelResponse>.from(
              map['career'].map((x) => CareerModelResponse.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorDetailResponse.fromJson(String source) =>
      DoctorDetailResponse.fromMap(json.decode(source));

  DoctorDetailResponse copyWith({
    String? id,
    String? fullName,
    String? phone,
    String? gender,
    String? dayOfBirth,
    String? email,
    String? address,
    String? fixedTime,
    double? ratings,
    String? avatar,
    String? biography,
    int? feePerMinutes,
    int? accountBalance,
    int? numberOfConsultation,
    String? updatedAt,
    bool? isActive,
    List<EducationAndCertificationModelResponse>? educationAndCertifications,
    List<SpecialtyModelResponse>? specialties,
    List<CareerModelResponse>? careers,
  }) {
    return DoctorDetailResponse(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dayOfBirth: dayOfBirth ?? this.dayOfBirth,
      email: email ?? this.email,
      address: address ?? this.address,
      fixedTime: fixedTime ?? this.fixedTime,
      ratings: ratings ?? this.ratings,
      avatar: avatar ?? this.avatar,
      biography: biography ?? this.biography,
      feePerMinutes: feePerMinutes ?? this.feePerMinutes,
      accountBalance: accountBalance ?? this.accountBalance,
      numberOfConsultation: numberOfConsultation ?? this.numberOfConsultation,
      updatedAt: updatedAt ?? this.updatedAt,
      educationAndCertifications:
          educationAndCertifications ?? this.educationAndCertifications,
      specialties: specialties ?? this.specialties,
      careers: careers ?? this.careers,
      isActive: isActive ?? this.isActive,
    );
  }
}

class CareerModelResponse {
  String? id;
  String? medicalInstitute;
  String? position;
  String? periodStart;
  String? periodEnd;
  CareerModelResponse({
    this.id,
    this.medicalInstitute,
    this.position,
    this.periodStart,
    this.periodEnd,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (medicalInstitute != null) {
      result.addAll({'medicalInstitute': medicalInstitute});
    }
    if (position != null) {
      result.addAll({'position': position});
    }
    if (periodStart != null) {
      result.addAll({'periodStart': periodStart});
    }
    if (periodEnd != null) {
      result.addAll({'periodEnd': periodEnd});
    }

    return result;
  }

  factory CareerModelResponse.fromMap(Map<String, dynamic> map) {
    return CareerModelResponse(
      id: map['id'],
      medicalInstitute: map['medicalInstitute'],
      position: map['position'],
      periodStart: map['periodStart'],
      periodEnd: map['periodEnd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CareerModelResponse.fromJson(String source) =>
      CareerModelResponse.fromMap(json.decode(source));
}

class SpecialtyModelResponse {
  String? specialty;
  String? levelOfSpecialty;
  String? image;
  SpecialtyModelResponse({
    this.specialty,
    this.levelOfSpecialty,
    this.image,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (specialty != null) {
      result.addAll({'specialty': specialty});
    }
    if (levelOfSpecialty != null) {
      result.addAll({'level_of_specialty': levelOfSpecialty});
    }
    if (image != null) {
      result.addAll({'image': image});
    }

    return result;
  }

  factory SpecialtyModelResponse.fromMap(Map<String, dynamic> map) {
    return SpecialtyModelResponse(
      specialty: map['specialty'],
      levelOfSpecialty: map['level_of_specialty'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialtyModelResponse.fromJson(String source) =>
      SpecialtyModelResponse.fromMap(json.decode(source));

  SpecialtyModelResponse copyWith({
    String? specialty,
    String? levelOfSpecialty,
    String? image,
  }) {
    return SpecialtyModelResponse(
      specialty: specialty ?? this.specialty,
      levelOfSpecialty: levelOfSpecialty ?? this.levelOfSpecialty,
      image: image ?? this.image,
    );
  }
}

class EducationAndCertificationModelResponse {
  String? typeOfEducationAndExperience;
  String? degreeOfEducation;
  String? institution;
  String? specialtyByDiploma;
  String? address;
  String? diplomaNumberAndSeries;
  String? dateOfReceiptOfDiploma;
  String? image;
  EducationAndCertificationModelResponse({
    this.typeOfEducationAndExperience,
    this.degreeOfEducation,
    this.institution,
    this.specialtyByDiploma,
    this.address,
    this.diplomaNumberAndSeries,
    this.dateOfReceiptOfDiploma,
    this.image,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (typeOfEducationAndExperience != null) {
      result.addAll(
          {'typeOfEducationAndExperience': typeOfEducationAndExperience});
    }
    if (degreeOfEducation != null) {
      result.addAll({'degreeOfEducation': degreeOfEducation});
    }
    if (institution != null) {
      result.addAll({'institution': institution});
    }
    if (specialtyByDiploma != null) {
      result.addAll({'specialtyByDiploma': specialtyByDiploma});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (diplomaNumberAndSeries != null) {
      result.addAll({'diplomaNumberAndSeries': diplomaNumberAndSeries});
    }
    if (dateOfReceiptOfDiploma != null) {
      result.addAll({'dateOfReceiptOfDiploma': dateOfReceiptOfDiploma});
    }
    if (image != null) {
      result.addAll({'image': image});
    }

    return result;
  }

  factory EducationAndCertificationModelResponse.fromMap(
      Map<String, dynamic> map) {
    return EducationAndCertificationModelResponse(
      typeOfEducationAndExperience: map['typeOfEducationAndExperience'],
      degreeOfEducation: map['degreeOfEducation'],
      institution: map['institution'],
      specialtyByDiploma: map['specialtyByDiploma'],
      address: map['address'],
      diplomaNumberAndSeries: map['diplomaNumberAndSeries'],
      dateOfReceiptOfDiploma: map['dateOfReceiptOfDiploma'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EducationAndCertificationModelResponse.fromJson(String source) =>
      EducationAndCertificationModelResponse.fromMap(json.decode(source));

  EducationAndCertificationModelResponse copyWith({
    String? typeOfEducationAndExperience,
    String? degreeOfEducation,
    String? institution,
    String? specialtyByDiploma,
    String? address,
    String? diplomaNumberAndSeries,
    String? dateOfReceiptOfDiploma,
    String? image,
  }) {
    return EducationAndCertificationModelResponse(
      typeOfEducationAndExperience:
          typeOfEducationAndExperience ?? this.typeOfEducationAndExperience,
      degreeOfEducation: degreeOfEducation ?? this.degreeOfEducation,
      institution: institution ?? this.institution,
      specialtyByDiploma: specialtyByDiploma ?? this.specialtyByDiploma,
      address: address ?? this.address,
      diplomaNumberAndSeries:
          diplomaNumberAndSeries ?? this.diplomaNumberAndSeries,
      dateOfReceiptOfDiploma:
          dateOfReceiptOfDiploma ?? this.dateOfReceiptOfDiploma,
      image: image ?? this.image,
    );
  }
}
