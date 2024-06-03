import 'dart:convert';

import 'package:healthline/data/api/models/responses/doctor_detail_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';

class TransactionResponse {
  String? id;
  String? requestId;
  String? orderId;
  bool? isPaid;
  int? amount;
  String? typePaid;
  String? createdAt;
  String? updatedAt;
  DoctorDetailResponse? doctor;
  UserResponse? user;
  TransactionResponse({
    this.id,
    this.requestId,
    this.orderId,
    this.isPaid,
    this.amount,
    this.typePaid,
    this.createdAt,
    this.updatedAt,
    this.doctor,
    this.user,
  });

  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(requestId != null){
      result.addAll({'requestId': requestId});
    }
    if(orderId != null){
      result.addAll({'orderId': orderId});
    }
    if(isPaid != null){
      result.addAll({'isPaid': isPaid});
    }
    if(amount != null){
      result.addAll({'amount': amount});
    }
    if(typePaid != null){
      result.addAll({'typePaid': typePaid});
    }
    if(createdAt != null){
      result.addAll({'created_at': createdAt});
    }
    if(updatedAt != null){
      result.addAll({'updated_at': updatedAt});
    }
    if(doctor != null){
      result.addAll({'doctor': doctor!.toMap()});
    }
    if(user != null){
      result.addAll({'user': user!.toMap()});
    }
  
    return result;
  }

  factory TransactionResponse.fromMap(Map<String, dynamic> map) {
    return TransactionResponse(
      id: map['id'],
      requestId: map['requestId'],
      orderId: map['orderId'],
      isPaid: map['isPaid'],
      amount: map['amount']?.toInt(),
      typePaid: map['typePaid'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      doctor: map['doctor'] != null ? DoctorDetailResponse.fromMap(map['doctor']) : null,
      user: map['user'] != null ? UserResponse.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionResponse.fromJson(String source) => TransactionResponse.fromMap(json.decode(source));
}
