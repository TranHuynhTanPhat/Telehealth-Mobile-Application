import 'dart:convert';

class FeedbackResponse {
  String? id;
  String? user;
  String? feedback;
  int? rated;
  FeedbackResponse({
    this.id,
    this.user,
    this.feedback,
    this.rated,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (user != null) {
      result.addAll({'user': user});
    }
    if (feedback != null) {
      result.addAll({'feedback': feedback});
    }
    if (rated != null) {
      result.addAll({'rated': rated});
    }

    return result;
  }

  factory FeedbackResponse.fromMap(Map<String, dynamic> map) {
    return FeedbackResponse(
      id: map['id'],
      user: map['user'],
      feedback: map['feedback'],
      rated: map['rated']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackResponse.fromJson(String source) =>
      FeedbackResponse.fromMap(json.decode(source));
}
