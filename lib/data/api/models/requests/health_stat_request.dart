import 'dart:convert';

import 'package:healthline/data/api/models/responses/health_stat_response.dart';

class HealthStatRequest {
  String? medicalId;
  List<HealthStatResponse>? stats;
  HealthStatRequest({
    this.medicalId,
    this.stats,
  });


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(medicalId != null){
      result.addAll({'medicalId': medicalId});
    }
    if(stats != null){
      result.addAll({'stats': stats!.map((x) => x.toMap()).toList()});
    }
  
    return result;
  }

  factory HealthStatRequest.fromMap(Map<String, dynamic> map) {
    return HealthStatRequest(
      medicalId: map['medicalId'],
      stats: map['stats'] != null ? List<HealthStatResponse>.from(map['stats']?.map((x) => HealthStatResponse.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthStatRequest.fromJson(String source) => HealthStatRequest.fromMap(json.decode(source));
}
