import 'package:flutter/foundation.dart';


class ToDo {
  final int id;
  final int userId;
  final String title;
  bool completed;

  ToDo({
    @required this.id,
    @required this.userId,
    @required this.title,
    @required this.completed,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}