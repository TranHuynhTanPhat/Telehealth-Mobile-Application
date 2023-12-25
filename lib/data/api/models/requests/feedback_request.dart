import 'dart:convert';

class FeedbackRequest {
  String? feedbackId;
  int? rated;
  String? feedback;

  FeedbackRequest({this.feedbackId, this.rated, this.feedback});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(feedbackId != null){
      result.addAll({'feedback_id': feedbackId});
    }
    if(rated != null){
      result.addAll({'rated': rated});
    }
    if(feedback != null){
      result.addAll({'feedback': feedback});
    }
  
    return result;
  }

  factory FeedbackRequest.fromMap(Map<String, dynamic> map) {
    return FeedbackRequest(
      feedbackId: map['feedback_d'],
      rated: map['rated']?.toInt(),
      feedback: map['feedback'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackRequest.fromJson(String source) => FeedbackRequest.fromMap(json.decode(source));
}
