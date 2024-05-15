import 'dart:convert';

class DoctorDetailRequest {
  String? id;
  String? fullName;
  String? phone;
  String? gender;
  String? dayOfBirth;
  String? email;
  String? address;
  List<List<int>>? fixedTime;
  double? ratings;
  String? avatar;
  String? biography;
  int? feePerMinutes;
  int? accountBalance;
  int? numberOfConsultation;
  String? updatedAt;

  List<EducationAndCertificationModelRequest>? educationAndCertifications;
  List<SpecialtyModelRequest>? specialties;
  List<CareerModelRequest>? careers;
  DoctorDetailRequest({
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

  // factory DoctorDetailRequest.fromMap(Map<String, dynamic> map) {
  //   return DoctorDetailRequest(
  //     fullName: map['full_name'],
  //     phone: map['phone'],
  //     gender: map['gender'],
  //     dayOfBirth: map['day_of_birth'],
  //     email: map['email'],
  //     address: map['address'],
  //     introduce: map['fixedTime'],
  //     educationAndCertifications: map['education_and_certifications'] != null
  //         ? List<EducationAndCertificationModelRequest>.from(
  //             map['education_and_certifications']
  //                 ?.map((x) => EducationAndCertificationModelRequest.fromMap(x)))
  //         : null,
  //     specialties: map['specialties'] != null
  //         ? List<SpecialtyModelRequest>.from(
  //             map['specialties']?.map((x) => SpecialtyModelRequest.fromMap(x)))
  //         : null,
  //     careers: map['careers'] != null
  //         ? List<CareerModelRequest>.from(
  //             map['careers']?.map((x) => CareerModelRequest.fromMap(x)))
  //         : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory DoctorDetailRequest.fromJson(String source) =>
  //     DoctorDetailRequest.fromMap(json.decode(source));

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
      result.addAll({'gender': true});
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
      result.addAll({'careers': careers!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory DoctorDetailRequest.fromMap(Map<String, dynamic> map) {
    return DoctorDetailRequest(
      id: map['id'],
      fullName: map['full_name'],
      phone: map['phone'],
      gender: map['gender'],
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
      educationAndCertifications: map['educationAndCertification'] != null
          ? List<EducationAndCertificationModelRequest>.from(
              map['educationAndCertification']
                  ?.map((x) => EducationAndCertificationModelRequest.fromMap(x)))
          : null,
      specialties: map['specialty'] != null
          ? List<SpecialtyModelRequest>.from(
              map['specialty']?.map((x) => SpecialtyModelRequest.fromMap(x)))
          : null,
      careers: map['careers'] != null
          ? List<CareerModelRequest>.from(
              map['careers']?.map((x) => CareerModelRequest.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorDetailRequest.fromJson(String source) =>
      DoctorDetailRequest.fromMap(json.decode(source));

  DoctorDetailRequest copyWith({
    String? id,
    String? fullName,
    String? phone,
    String? gender,
    String? dayOfBirth,
    String? email,
    String? address,
    List<List<int>>? fixedTime,
    double? ratings,
    String? avatar,
    String? biography,
    int? feePerMinutes,
    int? accountBalance,
    int? numberOfConsultation,
    String? updatedAt,
    List<EducationAndCertificationModelRequest>? educationAndCertifications,
    List<SpecialtyModelRequest>? specialties,
    List<CareerModelRequest>? careers,
  }) {
    return DoctorDetailRequest(
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
      educationAndCertifications: educationAndCertifications ?? this.educationAndCertifications,
      specialties: specialties ?? this.specialties,
      careers: careers ?? this.careers,
    );
  }
}

class CareerModelRequest {
  String? medicalInstitute;
  String? position;
  String? periodStart;
  String? periodEnd;
  CareerModelRequest({
    this.medicalInstitute,
    this.position,
    this.periodStart,
    this.periodEnd,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

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

  factory CareerModelRequest.fromMap(Map<String, dynamic> map) {
    return CareerModelRequest(
      medicalInstitute: map['medicalInstitute'],
      position: map['position'],
      periodStart: map['periodStart'],
      periodEnd: map['periodEnd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CareerModelRequest.fromJson(String source) =>
      CareerModelRequest.fromMap(json.decode(source));

  CareerModelRequest copyWith({
    String? medicalInstitute,
    String? position,
    String? periodStart,
    String? periodEnd,
  }) {
    return CareerModelRequest(
      medicalInstitute: medicalInstitute ?? this.medicalInstitute,
      position: position ?? this.position,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
    );
  }
}

class SpecialtyModelRequest {
  String? specialty;
  String? levelOfSpecialty;
  String? image;
  SpecialtyModelRequest({
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
      result.addAll({'levelOfSpecialty': levelOfSpecialty});
    }
    if (image != null) {
      result.addAll({'image': image});
    }

    return result;
  }

  factory SpecialtyModelRequest.fromMap(Map<String, dynamic> map) {
    return SpecialtyModelRequest(
      specialty: map['specialty'],
      levelOfSpecialty: map['levelOfSpecialty'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialtyModelRequest.fromJson(String source) =>
      SpecialtyModelRequest.fromMap(json.decode(source));

  SpecialtyModelRequest copyWith({
    String? specialty,
    String? levelOfSpecialty,
    String? image,
  }) {
    return SpecialtyModelRequest(
      specialty: specialty ?? this.specialty,
      levelOfSpecialty: levelOfSpecialty ?? this.levelOfSpecialty,
      image: image ?? this.image,
    );
  }
}

class EducationAndCertificationModelRequest {
  String? typeOfEducationAndExperience;
  String? degreeOfEducation;
  String? institution;
  String? specialtyByDiploma;
  String? address;
  String? diplomaNumberAndSeries;
  String? dateOfReceiptOfDiploma;
  String? image;
  EducationAndCertificationModelRequest({
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

  factory EducationAndCertificationModelRequest.fromMap(Map<String, dynamic> map) {
    return EducationAndCertificationModelRequest(
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

  factory EducationAndCertificationModelRequest.fromJson(String source) =>
      EducationAndCertificationModelRequest.fromMap(json.decode(source));

  EducationAndCertificationModelRequest copyWith({
    String? typeOfEducationAndExperience,
    String? degreeOfEducation,
    String? institution,
    String? specialtyByDiploma,
    String? address,
    String? diplomaNumberAndSeries,
    String? dateOfReceiptOfDiploma,
    String? image,
  }) {
    return EducationAndCertificationModelRequest(
      typeOfEducationAndExperience: typeOfEducationAndExperience ?? this.typeOfEducationAndExperience,
      degreeOfEducation: degreeOfEducation ?? this.degreeOfEducation,
      institution: institution ?? this.institution,
      specialtyByDiploma: specialtyByDiploma ?? this.specialtyByDiploma,
      address: address ?? this.address,
      diplomaNumberAndSeries: diplomaNumberAndSeries ?? this.diplomaNumberAndSeries,
      dateOfReceiptOfDiploma: dateOfReceiptOfDiploma ?? this.dateOfReceiptOfDiploma,
      image: image ?? this.image,
    );
  }
}
