import 'package:flutter/src/material/dropdown.dart';
import 'package:projectsmangment/model/Salary.dart';

class Developer {
  int? id;
  Object? idObject;
  List<Salary>? salary;
  String? name;
  // String? userNamer;
  String? password;
  Developer(
      {this.id,
      this.name,
      // this.userNamer,
      this.idObject,
      this.password,
      this.salary});
  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      id: json['id'],
      idObject: json['id'] as Object,
      name: json['name'],
      // userNamer: json['userNamer'] == null ? null : json['userNamer'],
      password: json['password'], //type cast error
      salary: json['salary'] == null
          ? null
          : (json['salary'] as List).map((e) => Salary.fromJson(e)).toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "userNamer": userNamer ,
        "password": password,
      };
}
