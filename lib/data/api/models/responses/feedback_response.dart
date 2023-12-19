import 'dart:convert';

class FeedbackResponse {
  String? feedbackId;
  int? rated;
  String? feedback;

  FeedbackResponse({this.feedbackId, this.rated, this.feedback});

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

  factory FeedbackResponse.fromMap(Map<String, dynamic> map) {
    return FeedbackResponse(
      feedbackId: map['feedback_d'],
      rated: map['rated']?.toInt(),
      feedback: map['feedback'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackResponse.fromJson(String source) => FeedbackResponse.fromMap(json.decode(source));
}
