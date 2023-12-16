import 'dart:convert';

import 'package:healthline/data/api/models/responses/consultaion_response.dart';

class AllConsultationResponse {
  List<ConsultationResponse> coming;
  List<ConsultationResponse> finish;
  List<ConsultationResponse> cancel;
  AllConsultationResponse({
    required this.coming,
    required this.finish,
    required this.cancel,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'coming': coming.map((x) => x.toMap()).toList()});
    result.addAll({'finish': finish.map((x) => x.toMap()).toList()});
    result.addAll({'cancel': cancel.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory AllConsultationResponse.fromMap(Map<String, dynamic> map) {
    return AllConsultationResponse(
      coming: List<ConsultationResponse>.from(map['coming']?.map((x) => ConsultationResponse.fromMap(x))),
      finish: List<ConsultationResponse>.from(map['finish']?.map((x) => ConsultationResponse.fromMap(x))),
      cancel: List<ConsultationResponse>.from(map['cancel']?.map((x) => ConsultationResponse.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllConsultationResponse.fromJson(String source) => AllConsultationResponse.fromMap(json.decode(source));
}
