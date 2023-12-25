import 'dart:convert';

import 'package:healthline/data/api/models/responses/comment_response.dart';

class FeedbackResponse {
  String? id;
  UserResponse? user;
  String? feedback;
  int? rated;
  String? createdAt;
  FeedbackResponse(
      {this.id, this.user, this.feedback, this.rated, this.createdAt});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (user != null) {
      result.addAll({'user': user?.toJson()});
    }
    if (feedback != null) {
      result.addAll({'feedback': feedback});
    }
    if (rated != null) {
      result.addAll({'rated': rated});
    }
    if (createdAt != null) {
      result.addAll({'created_at': createdAt});
    }

    return result;
  }

  factory FeedbackResponse.fromMap(Map<String, dynamic> map) {
    return FeedbackResponse(
      id: map['id'],
      user: UserResponse.fromMap(map['user']),
      feedback: map['feedback'],
      rated: map['rated']?.toInt(),
      createdAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackResponse.fromJson(String source) =>
      FeedbackResponse.fromMap(json.decode(source));
}
