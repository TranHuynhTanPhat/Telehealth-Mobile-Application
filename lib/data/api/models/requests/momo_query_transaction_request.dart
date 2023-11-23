import 'dart:convert';

class MomoQueryTransactionRequest {
  String? partnerCode;
  String? requestId;
  String? orderId;
  String? lang;
  String? signature;
  MomoQueryTransactionRequest({
    this.partnerCode,
    this.requestId,
    this.orderId,
    this.lang,
    this.signature,
  });

  // MomoQueryTransactionRequest(
  //     {this.partnerCode,
  //     this.requestId,
  //     this.orderId,
  //     this.lang,
  //     this.signature});

  // MomoQueryTransactionRequest.fromJson(Map<String, dynamic> json) {
  //   partnerCode = json['partnerCode'];
  //   requestId = json['requestId'];
  //   orderId = json['orderId'];
  //   lang = json['lang'];
  //   signature = json['signature'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['partnerCode'] = this.partnerCode;
  //   data['requestId'] = this.requestId;
  //   data['orderId'] = this.orderId;
  //   data['lang'] = this.lang;
  //   data['signature'] = this.signature;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(partnerCode != null){
      result.addAll({'partnerCode': partnerCode});
    }
    if(requestId != null){
      result.addAll({'requestId': requestId});
    }
    if(orderId != null){
      result.addAll({'orderId': orderId});
    }
    if(lang != null){
      result.addAll({'lang': lang});
    }
    if(signature != null){
      result.addAll({'signature': signature});
    }
  
    return result;
  }

  factory MomoQueryTransactionRequest.fromMap(Map<String, dynamic> map) {
    return MomoQueryTransactionRequest(
      partnerCode: map['partnerCode'],
      requestId: map['requestId'],
      orderId: map['orderId'],
      lang: map['lang'],
      signature: map['signature'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MomoQueryTransactionRequest.fromJson(String source) => MomoQueryTransactionRequest.fromMap(json.decode(source));
}
