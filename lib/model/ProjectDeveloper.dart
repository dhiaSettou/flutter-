import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:projectsmangment/model/Project.dart';
import 'package:projectsmangment/model/Task.dart';

class ProjectDeveloper {
  int? id;
  String? projectName;
  String? developerName;
  int? id_Project;
  int? id_Developer;
  bool? fullDay;
  DateTime? startedTime;
  DateTime? finishedTime;
  Project? project;
  bool? isExpended;
  List<Object>? resourceIds;
  List<Task>? tasks;
  
  ProjectDeveloper(
      {this.id,
      this.id_Developer,
      this.id_Project,
      this.projectName,
      this.isExpended = false,
      this.developerName,
      this.finishedTime,
      this.fullDay = true,
      this.project,
      this.tasks,
      this.resourceIds,
      this.startedTime});
  factory ProjectDeveloper.fromJson(Map<String, dynamic> json) {
    return ProjectDeveloper(
      id: json['id'],
      id_Project: json['projectId'],

      id_Developer: json['developerId'],
      fullDay: json['fullDay'],
      //if null keep it null
      startedTime: json['startedTime'] == null
          ? null
          : DateTime.parse(json['startedTime']),
      finishedTime: json['finishedTime'] == null
          ? null
          : DateTime.parse(json['finishedTime']),
      projectName: json['projectName'],
      developerName: json['developerName'],
      resourceIds: <Object>[json['developerId']],
      project: Project.fromJson(json['project']),
      tasks: json['tasks'] != null
          ? (json['tasks'] as List).map((e) => Task.fromJson(e)).toList()
          : List.empty(),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,

        "developerId": id_Developer,
        "projectId": id_Project,
        "fullDay": fullDay,
        "tasks": tasks,

        "startedTime":
            startedTime != null ? startedTime!.toIso8601String() : null,

        // != null
        //     ? DateFormat('yyyy-MM-dd hh:mm:ss').format(startedTime!) + ".000"
        //     : null,
        "finishedTime":
            finishedTime != null ? finishedTime!.toIso8601String() : null,
        // "projectName": projectName,
        // "developerName": developerName,
        // "project": project,
      };
}
