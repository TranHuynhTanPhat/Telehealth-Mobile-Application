import 'dart:convert';

class NewsResponse {
  String? title;
  String? content;
  String? id;
  String? photo;
  String? createdAt;
  String? updatedAt;

  NewsResponse(
      {this.title,
      this.content,
      this.id,
      this.photo,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (content != null) {
      result.addAll({'content': content});
    }
    if (id != null) {
      result.addAll({'_id': id});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }

    return result;
  }

  factory NewsResponse.fromMap(Map<String, dynamic> map) {
    return NewsResponse(
      title: map['title'],
      content: map['content'],
      id: map['_id'],
      photo: map['photo'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsResponse.fromJson(String source) =>
      NewsResponse.fromMap(json.decode(source));
}
