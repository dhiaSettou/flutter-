import 'package:projectsmangment/model/ProjectDeveloper.dart';

class Task {
  int? id;
  String? description;
  int? projectDeveloperId;
  Task({this.id, this.description, this.projectDeveloperId});
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
      projectDeveloperId: json['projectDeveloperId'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "projectDeveloperId": projectDeveloperId,
      };
}
