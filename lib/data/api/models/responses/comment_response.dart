import 'dart:convert';

import 'package:healthline/data/api/models/responses/user_response.dart';

class CommentResponse {
  String? id;
  UserResponse? user;
  String? text;
  String? postId;
  List<String?>? likes;
  String? createdAt;
  String? updatedAt;

  CommentResponse(
      {this.id,
      this.user,
      this.text,
      this.likes,
      this.createdAt,
      this.postId,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (user != null) {
      result.addAll({'user': user!});
    }
    if (text != null) {
      result.addAll({'text': text});
    }
    if (likes != null) {
      result.addAll({'likes': likes!.map((x) => x).toList()});
    }
    if (postId != null) {
      result.addAll({'postId': postId!});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }

    return result;
  }

  factory CommentResponse.fromMap(Map<String, dynamic> map) {
    return CommentResponse(
      id: map['_id'],
      user: map['user'] != null ? UserResponse.fromMap(map['user']) : null,
      text: map['text'],
      likes: map['likes'] != null
          ? List<String?>.from(map['likes']?.map((x) => x.toString()))
          : null,
      postId: map['postId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentResponse.fromJson(String source) =>
      CommentResponse.fromMap(json.decode(source));
}

// class UserResponse {
//   String? uid;
//   String? fullName;
//   String? avatar;

//   UserResponse({this.uid, this.fullName, this.avatar});

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     if (uid != null) {
//       result.addAll({'uid': uid});
//     }
//     if (fullName != null) {
//       result.addAll({'full_name': fullName});
//     }
//     if (avatar != null) {
//       result.addAll({'avatar': avatar});
//     }

//     return result;
//   }

//   factory UserResponse.fromMap(Map<String, dynamic> map) {
//     return UserResponse(
//       uid: map['uid'],
//       fullName: map['full_name'],
//       avatar: map['avatar'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserResponse.fromJson(String source) =>
//       UserResponse.fromMap(json.decode(source));
// }
