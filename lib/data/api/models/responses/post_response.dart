import 'dart:convert';

class PostResponse {
  String? id;
  String? description;
  List<String>? photo;
  UserResponse? user;
  List<String>? likes;
  String? updatedAt;

  PostResponse(
      {this.id,
      this.description,
      this.photo,
      this.user,
      this.likes,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (user != null) {
      result.addAll({'user': user!.toMap()});
    }
    if (likes != null) {
      result.addAll({'likes': likes!.map((x) => x).toList()});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }

    return result;
  }

  factory PostResponse.fromMap(Map<String, dynamic> map) {
    return PostResponse(
      id: map['id'],
      description: map['description'],
      photo: List<String>.from(map['photo']),
      user: map['user'] != null ? UserResponse.fromMap(map['user']) : null,
      likes: map['likes'] != null
          ? List<String>.from(map['likes']?.map((x) => x))
          : null,
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostResponse.fromJson(String source) =>
      PostResponse.fromMap(json.decode(source));
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
