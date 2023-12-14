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
