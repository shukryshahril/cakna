import 'package:flutter/cupertino.dart';
import 'package:cakna/utils.dart';

class RoomField {
  static const createdTime = 'createdTime';
}

class Room {
  DateTime createdTime;
  String club;
  String title;
  String id;
  String description;
  bool isDone;

  Room({
    @required this.createdTime,
    @required this.club,
    @required this.title,
    this.description = '',
    this.id,
    this.isDone = false,
  });

  static Room fromJson(Map<String, dynamic> json) => Room(
        createdTime: Utils.toDateTime(json['createdTime']),
        club: json['club'],
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'club': club,
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
      };
}
