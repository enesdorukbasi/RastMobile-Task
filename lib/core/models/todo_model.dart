import 'dart:convert';

class ToDoModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final String assignee;
  final String date;

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.assignee,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'assignee': assignee,
      'date': date,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'],
      assignee: map['assignee'],
      date: map['date'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory ToDoModel.fromJson(String json) {
    return ToDoModel.fromMap(jsonDecode(json));
  }
}
