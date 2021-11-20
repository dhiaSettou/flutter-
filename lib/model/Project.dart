import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Project {
  int? id;
  String? name;
  bool? isExpended;
  bool? isSelected;
  DateTime? from;
  bool? fullDay;
  DateTime? to = DateTime.now();
  String? color;
  String? note;
  DateTime? date;

  Project({
    this.id,
    this.name,
    this.isExpended = false,
    this.fullDay = true,
    this.isSelected = false,
    this.color,
    this.note,
    this.from,
    this.to,
    this.date,
  });
// get
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      note: json["note"],
      from: json["from"],
      date: DateTime.parse(json["date"] ?? "2021-10-08"),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "note": note,
        "from": from,
        "date": date,
      };
}
