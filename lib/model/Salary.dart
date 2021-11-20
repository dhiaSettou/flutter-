import 'package:intl/intl.dart';
import 'package:projectsmangment/model/Developer.dart';

import 'Task.dart';

class Salary {
  int? id;
  double? salary;
  DateTime? startsAt;
  int? developer_id;

  Salary({this.id, this.salary, this.startsAt, this.developer_id});
  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      id: json['id'],
      salary: json['salary'],
      startsAt:
          json['startsAt'] == null ? null : DateTime.parse(json['startsAt']),
      developer_id: json['developer_id'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "salary": salary,
        "startsAt": startsAt != null ? startsAt!.toIso8601String() : null,
        "developer_id": developer_id,
      };
}
