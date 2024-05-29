import 'dart:convert';

class MessageResponse {
  String? id;
  String? roomId;
  String? senderId;
  String? text;
  String? type;
  bool? isDelete;
  String? createdAt;
  String? updatedAt;
  MessageResponse({
    this.id,
    this.roomId,
    this.senderId,
    this.text,
    this.type,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'_id': id});
    }
    if(roomId != null){
      result.addAll({'room_id': roomId});
    }
    if(senderId != null){
      result.addAll({'sender_id': senderId});
    }
    if(text != null){
      result.addAll({'text': text});
    }
    if(type != null){
      result.addAll({'type': type});
    }
    if(isDelete != null){
      result.addAll({'isDelete': isDelete});
    }
    if(createdAt != null){
      result.addAll({'createdAt': createdAt});
    }
    if(updatedAt != null){
      result.addAll({'updatedAt': updatedAt});
    }
  
    return result;
  }

  factory MessageResponse.fromMap(Map<String, dynamic> map) {
    return MessageResponse(
      id: map['_id'],
      roomId: map['room_id'],
      senderId: map['sender_id'],
      text: map['text'],
      type: map['type'],
      isDelete: map['isDelete'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageResponse.fromJson(String source) => MessageResponse.fromMap(json.decode(source));
}
