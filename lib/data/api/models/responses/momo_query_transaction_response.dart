import 'dart:convert';

class MomoQueryTransactionResponse {
  String? partnerCode;
  String? orderId;
  String? requestId;
  String? extraData;
  int? amount;
  int? transId;
  String? payType;
  int? resultCode;
  List<dynamic>? refundTrans;
  String? message;
  int? responseTime;
  int? lastUpdated;
  String? signature;
  String? paymentOption;
  MomoQueryTransactionResponse({
    this.partnerCode,
    this.orderId,
    this.requestId,
    this.extraData,
    this.amount,
    this.transId,
    this.payType,
    this.resultCode,
    this.refundTrans,
    this.message,
    this.responseTime,
    this.lastUpdated,
    this.signature,
    this.paymentOption,
  });

  // MomoQueryTransactionResponse(
  //     {this.partnerCode,
  //     this.orderId,
  //     this.requestId,
  //     this.extraData,
  //     this.amount,
  //     this.transId,
  //     this.payType,
  //     this.resultCode,
  //     this.refundTrans,
  //     this.message,
  //     this.responseTime,
  //     this.lastUpdated,
  //     this.signature,
  //     this.paymentOption});

  // MomoQueryTransactionResponse.fromJson(Map<String, dynamic> json) {
  //   partnerCode = json['partnerCode'];
  //   orderId = json['orderId'];
  //   requestId = json['requestId'];
  //   extraData = json['extraData'];
  //   amount = json['amount'];
  //   transId = json['transId'];
  //   payType = json['payType'];
  //   resultCode = json['resultCode'];
  //   if (json['refundTrans'] != null) {
  //     List<dynamic>.from(json['refundTrans']?.map((x) => x));
  //   }
  //   message = json['message'];
  //   responseTime = json['responseTime'];
  //   lastUpdated = json['lastUpdated'];
  //   signature = json['signature'];
  //   paymentOption = json['paymentOption'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['partnerCode'] = this.partnerCode;
  //   data['orderId'] = this.orderId;
  //   data['requestId'] = this.requestId;
  //   data['extraData'] = this.extraData;
  //   data['amount'] = this.amount;
  //   data['transId'] = this.transId;
  //   data['payType'] = this.payType;
  //   data['resultCode'] = this.resultCode;
  //   if (this.refundTrans != null) {
  //     data['refundTrans'] = this.refundTrans!.map((v) => v.toJson()).toList();
  //   }
  //   data['message'] = this.message;
  //   data['responseTime'] = this.responseTime;
  //   data['lastUpdated'] = this.lastUpdated;
  //   data['signature'] = this.signature;
  //   data['paymentOption'] = this.paymentOption;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(partnerCode != null){
      result.addAll({'partnerCode': partnerCode});
    }
    if(orderId != null){
      result.addAll({'orderId': orderId});
    }
    if(requestId != null){
      result.addAll({'requestId': requestId});
    }
    if(extraData != null){
      result.addAll({'extraData': extraData});
    }
    if(amount != null){
      result.addAll({'amount': amount});
    }
    if(transId != null){
      result.addAll({'transId': transId});
    }
    if(payType != null){
      result.addAll({'payType': payType});
    }
    if(resultCode != null){
      result.addAll({'resultCode': resultCode});
    }
    if(refundTrans != null){
      result.addAll({'refundTrans': refundTrans});
    }
    if(message != null){
      result.addAll({'message': message});
    }
    if(responseTime != null){
      result.addAll({'responseTime': responseTime});
    }
    if(lastUpdated != null){
      result.addAll({'lastUpdated': lastUpdated});
    }
    if(signature != null){
      result.addAll({'signature': signature});
    }
    if(paymentOption != null){
      result.addAll({'paymentOption': paymentOption});
    }
  
    return result;
  }

  factory MomoQueryTransactionResponse.fromMap(Map<String, dynamic> map) {
    return MomoQueryTransactionResponse(
      partnerCode: map['partnerCode'],
      orderId: map['orderId'],
      requestId: map['requestId'],
      extraData: map['extraData'],
      amount: map['amount']?.toInt(),
      transId: map['transId']?.toInt(),
      payType: map['payType'],
      resultCode: map['resultCode']?.toInt(),
      refundTrans: List<dynamic>.from(map['refundTrans']),
      message: map['message'],
      responseTime: map['responseTime']?.toInt(),
      lastUpdated: map['lastUpdated']?.toInt(),
      signature: map['signature'],
      paymentOption: map['paymentOption'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MomoQueryTransactionResponse.fromJson(String source) => MomoQueryTransactionResponse.fromMap(json.decode(source));
}
