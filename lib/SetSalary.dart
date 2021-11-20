import 'dart:ui';
import 'package:get/get.dart';
import 'package:projectsmangment/Developers.dart';
import 'package:projectsmangment/UserView.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/Project.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:projectsmangment/model/Salary.dart';

import 'Api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetSalary extends StatefulWidget {
  @override
  _SetSalaryState createState() => _SetSalaryState();
}

class _SetSalaryState extends State<SetSalary> {
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) => setState(() => currentColor = color);
  Color currentColor = Color(0xff443a49);

  Color pickerColor = Color(0xff443a49);

  bool isSwitched = false;
  String? projectName;
  String? DeveloperName;
  DateTime now = DateTime.now();

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Developer developer = Get.arguments;

  double? salary;

  String? note;

  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Developer Salary"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                labelText: "Developer's salary :",
                labelStyle: TextStyle(color: Colors.black),
                hintText: "Enter Developer's salary :",
              ),
              onChanged: (value) {
                setState(() {
                  salary = double.parse(value);
                });
              },
            ),
            OutlinedButton(
                onPressed: () {
                  print(Get.arguments.id);
                  Api.saveSalary(
                    Salary(
                      salary: salary,
                      startsAt: date,
                      developer_id: Get.arguments.id,
                    ),
                  );
                  Get.to(Developers());
                },
                child: Text("Set"))
          ])),
    );
  }
}
