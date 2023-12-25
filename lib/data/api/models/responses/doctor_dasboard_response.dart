import 'dart:convert';

class DoctorDasboardResponse {
  int? money;
  int? countConsul;
  int? badFeedback;
  DoctorDasboardResponse({
    this.money,
    this.countConsul,
    this.badFeedback,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(money != null){
      result.addAll({'money': money});
    }
    if(countConsul != null){
      result.addAll({'countConsul': countConsul});
    }
    if(badFeedback != null){
      result.addAll({'badFeedback': badFeedback});
    }
  
    return result;
  }

  factory DoctorDasboardResponse.fromMap(Map<String, dynamic> map) {
    return DoctorDasboardResponse(
      money: map['money']?.toInt(),
      countConsul: map['countConsul']?.toInt(),
      badFeedback: map['badFeedback']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorDasboardResponse.fromJson(String source) => DoctorDasboardResponse.fromMap(json.decode(source));
}
