import 'dart:convert';

class ApiException implements Exception {
  final int? statusCode;
  final String? status;
  final dynamic message;
  final dynamic error;

  ApiException({this.statusCode, this.status, this.message, this.error});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(statusCode != null){
      result.addAll({'statusCode': statusCode});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    result.addAll({'message': message});
    result.addAll({'error': error});
  
    return result;
  }

  factory ApiException.fromMap(Map<String, dynamic> map) {
    return ApiException(
      statusCode: map['statusCode']?.toInt(),
      status: map['status'],
      message: map['message'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiException.fromJson(String source) => ApiException.fromMap(json.decode(source));
}
