import 'dart:convert';

class CommentResponse {
  String? id;
  UserResponse? user;
  String? text;
  List<String?>? likes;
  String? createdAt;

  CommentResponse({this.id, this.user, this.text, this.likes, this.createdAt});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (user != null) {
      result.addAll({'user': user!.toMap()});
    }
    if (text != null) {
      result.addAll({'text': text});
    }
    if (likes != null) {
      result.addAll({'likes': likes!.map((x) => x).toList()});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }

    return result;
  }

  factory CommentResponse.fromMap(Map<String, dynamic> map) {
    return CommentResponse(
      id: map['id'],
      user: map['user'] != null ? UserResponse.fromMap(map['user']) : null,
      text: map['text'],
      likes: map['likes'] != null
          ? List<String?>.from(map['likes']?.map((x) => x.toString()))
          : null,
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentResponse.fromJson(String source) =>
      CommentResponse.fromMap(json.decode(source));
}

class UserResponse {
  String? uid;
  String? fullName;
  String? avatar;

  UserResponse({this.uid, this.fullName, this.avatar});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (fullName != null) {
      result.addAll({'full_name': fullName});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }

    return result;
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      uid: map['uid'],
      fullName: map['full_name'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));
}
