import 'dart:convert';

class MomoCreateResponse {
  String? partnerCode;
  String? orderId;
  String? requestId;
  int? amount;
  int? responseTime;
  String? message;
  int? resultCode;
  String? payUrl;
  String? deeplink;
  String? qrCodeUrl;
  String? applink;
  String? deeplinkMiniApp;
  String? signature;
  MomoCreateResponse({
    this.partnerCode,
    this.orderId,
    this.requestId,
    this.amount,
    this.responseTime,
    this.message,
    this.resultCode,
    this.payUrl,
    this.deeplink,
    this.qrCodeUrl,
    this.applink,
    this.deeplinkMiniApp,
    this.signature,
  });

  // MomoCreateResponse.fromJson(Map<String, dynamic> json) {
  //   partnerCode = json['partnerCode'];
  //   orderId = json['orderId'];
  //   requestId = json['requestId'];
  //   amount = json['amount'];
  //   responseTime = json['responseTime'];
  //   message = json['message'];
  //   resultCode = json['resultCode'];
  //   payUrl = json['payUrl'];
  //   deeplink = json['deeplink'];
  //   qrCodeUrl = json['qrCodeUrl'];
  //   applink = json['applink'];
  //   deeplinkMiniApp = json['deeplinkMiniApp'];
  //   signature = json['signature'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['partnerCode'] = this.partnerCode;
  //   data['orderId'] = this.orderId;
  //   data['requestId'] = this.requestId;
  //   data['amount'] = this.amount;
  //   data['responseTime'] = this.responseTime;
  //   data['message'] = this.message;
  //   data['resultCode'] = this.resultCode;
  //   data['payUrl'] = this.payUrl;
  //   data['deeplink'] = this.deeplink;
  //   data['qrCodeUrl'] = this.qrCodeUrl;
  //   data['applink'] = this.applink;
  //   data['deeplinkMiniApp'] = this.deeplinkMiniApp;
  //   data['signature'] = this.signature;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (partnerCode != null) {
      result.addAll({'partnerCode': partnerCode});
    }
    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (responseTime != null) {
      result.addAll({'responseTime': responseTime});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (resultCode != null) {
      result.addAll({'resultCode': resultCode});
    }
    if (payUrl != null) {
      result.addAll({'payUrl': payUrl});
    }
    if (deeplink != null) {
      result.addAll({'deeplink': deeplink});
    }
    if (qrCodeUrl != null) {
      result.addAll({'qrCodeUrl': qrCodeUrl});
    }
    if (applink != null) {
      result.addAll({'applink': applink});
    }
    if (deeplinkMiniApp != null) {
      result.addAll({'deeplinkMiniApp': deeplinkMiniApp});
    }
    if (signature != null) {
      result.addAll({'signature': signature});
    }

    return result;
  }

  factory MomoCreateResponse.fromMap(Map<String, dynamic> map) {
    return MomoCreateResponse(
      partnerCode: map['partnerCode'],
      orderId: map['orderId'],
      requestId: map['requestId'],
      amount: map['amount']?.toInt(),
      responseTime: map['responseTime']?.toInt(),
      message: map['message'],
      resultCode: map['resultCode']?.toInt(),
      payUrl: map['payUrl'],
      deeplink: map['deeplink'],
      qrCodeUrl: map['qrCodeUrl'],
      applink: map['applink'],
      deeplinkMiniApp: map['deeplinkMiniApp'],
      signature: map['signature'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MomoCreateResponse.fromJson(String source) =>
      MomoCreateResponse.fromMap(json.decode(source));
}
