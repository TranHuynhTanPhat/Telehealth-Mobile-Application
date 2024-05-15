import 'dart:convert';

import 'package:healthline/res/enum.dart';

class SocketNotification {
  From? from;
  String? to;
  TypeNotificationSocket? type;
  List<Content>? content;
  bool? seen;

  SocketNotification({this.from, this.to, this.type, this.content, this.seen});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (from != null) {
      result.addAll({'from': from!.toMap()});
    }
    if (to != null) {
      result.addAll({'to': to});
    }
    if (type != null) {
      result.addAll({'type': type!.name});
    }
    if (content != null) {
      result.addAll({'content': content!.map((x) => x.toMap()).toList()});
    }
    if (seen != null) {
      result.addAll({'seen': seen});
    }

    return result;
  }

  factory SocketNotification.fromMap(Map<String, dynamic> map) {
    return SocketNotification(
      from: map['from'] != null ? From.fromMap(map['from']) : null,
      to: map['to'],
      type: TypeNotificationSocket.values
          .firstWhere((e) => e.name == map['type']),
      content: map['content'] != null
          ? List<Content>.from(map['content']?.map((x) => Content.fromMap(x)))
          : null,
      seen: map['seen'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketNotification.fromJson(String source) =>
      SocketNotification.fromMap(json.decode(source));
}

class From {
  String? id;
  String? fullName;
  String? avatar;

  From({this.id, this.fullName, this.avatar});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (fullName != null) {
      result.addAll({'full_name': fullName});
    }
    if (avatar != null) {
      result.addAll({'avatar': avatar});
    }

    return result;
  }

  factory From.fromMap(Map<String, dynamic> map) {
    return From(
      id: map['id'],
      fullName: map['full_name'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory From.fromJson(String source) => From.fromMap(json.decode(source));
}

class Content {
  String? date;
  String? expectedTime;

  Content({this.date, this.expectedTime});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (date != null) {
      result.addAll({'date': date});
    }
    if (expectedTime != null) {
      result.addAll({'expected_time': expectedTime});
    }

    return result;
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      date: map['date'],
      expectedTime: map['expected_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source));
}
