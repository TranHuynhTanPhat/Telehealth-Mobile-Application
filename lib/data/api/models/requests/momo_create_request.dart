import 'dart:convert';

class MomoCreateRequest {
  String? partnerCode;
  String? partnerName;
  String? storeId;
  String? requestType;
  String? ipnUrl;
  String? redirectUrl;
  String? orderId;
  String? amount;
  String? lang;
  String? autoCapture;
  String? orderInfo;
  String? requestId;
  String? extraData;
  String? signature;
  MomoCreateRequest({
    this.partnerCode,
    this.partnerName,
    this.storeId,
    this.requestType,
    this.ipnUrl,
    this.redirectUrl,
    this.orderId,
    this.amount,
    this.lang,
    this.autoCapture,
    this.orderInfo,
    this.requestId,
    this.extraData,
    this.signature,
  });

  // MomoCreateRequest(
  //     {this.partnerCode,
  //     this.partnerName,
  //     this.storeId,
  //     this.requestType,
  //     this.ipnUrl,
  //     this.redirectUrl,
  //     this.orderId,
  //     this.amount,
  //     this.lang,
  //     this.autoCapture,
  //     this.orderInfo,
  //     this.requestId,
  //     this.extraData,
  //     this.signature});

  // MomoCreateRequest.fromJson(Map<String, dynamic> json) {
  //   partnerCode = json['partnerCode'];
  //   partnerName = json['partnerName'];
  //   storeId = json['storeId'];
  //   requestType = json['requestType'];
  //   ipnUrl = json['ipnUrl'];
  //   redirectUrl = json['redirectUrl'];
  //   orderId = json['orderId'];
  //   amount = json['amount'];
  //   lang = json['lang'];
  //   autoCapture = json['autoCapture'];
  //   orderInfo = json['orderInfo'];
  //   requestId = json['requestId'];
  //   extraData = json['extraData'];
  //   signature = json['signature'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['partnerCode'] = this.partnerCode;
  //   data['partnerName'] = this.partnerName;
  //   data['storeId'] = this.storeId;
  //   data['requestType'] = this.requestType;
  //   data['ipnUrl'] = this.ipnUrl;
  //   data['redirectUrl'] = this.redirectUrl;
  //   data['orderId'] = this.orderId;
  //   data['amount'] = this.amount;
  //   data['lang'] = this.lang;
  //   data['autoCapture'] = this.autoCapture;
  //   data['orderInfo'] = this.orderInfo;
  //   data['requestId'] = this.requestId;
  //   data['extraData'] = this.extraData;
  //   data['signature'] = this.signature;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (partnerCode != null) {
      result.addAll({'partnerCode': partnerCode});
    }
    if (partnerName != null) {
      result.addAll({'partnerName': partnerName});
    }
    if (storeId != null) {
      result.addAll({'storeId': storeId});
    }
    if (requestType != null) {
      result.addAll({'requestType': requestType});
    }
    if (ipnUrl != null) {
      result.addAll({'ipnUrl': ipnUrl});
    }
    if (redirectUrl != null) {
      result.addAll({'redirectUrl': redirectUrl});
    }
    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (lang != null) {
      result.addAll({'lang': lang});
    }
    if (autoCapture != null) {
      result.addAll({'autoCapture': autoCapture});
    }
    if (orderInfo != null) {
      result.addAll({'orderInfo': orderInfo});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (extraData != null) {
      result.addAll({'extraData': extraData});
    }
    if (signature != null) {
      result.addAll({'signature': signature});
    }

    return result;
  }

  factory MomoCreateRequest.fromMap(Map<String, dynamic> map) {
    return MomoCreateRequest(
      partnerCode: map['partnerCode'],
      partnerName: map['partnerName'],
      storeId: map['storeId'],
      requestType: map['requestType'],
      ipnUrl: map['ipnUrl'],
      redirectUrl: map['redirectUrl'],
      orderId: map['orderId'],
      amount: map['amount'],
      lang: map['lang'],
      autoCapture: map['autoCapture'],
      orderInfo: map['orderInfo'],
      requestId: map['requestId'],
      extraData: map['extraData'],
      signature: map['signature'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MomoCreateRequest.fromJson(String source) =>
      MomoCreateRequest.fromMap(json.decode(source));
}
