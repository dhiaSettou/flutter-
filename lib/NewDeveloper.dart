import 'dart:ui';
import 'package:get/get.dart';
import 'package:projectsmangment/Developers.dart';
import 'package:projectsmangment/UserView.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/Project.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'Api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewDeveloper extends StatefulWidget {
  @override
  _NewDeveloperState createState() => _NewDeveloperState();
}

class _NewDeveloperState extends State<NewDeveloper> {
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) => setState(() => currentColor = color);
  Color currentColor = Color(0xff443a49);

  Color pickerColor = Color(0xff443a49);

  bool isSwitched = false;
  String? projectName;
  String? DeveloperName;
  double? salary;

  String? note;

  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Developer"),
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
                labelText: 'Developer name :',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter Developer name :',
              ),
              onChanged: (value) {
                setState(() {
                  DeveloperName = value;
                });
              },
            ),
            // SizedBox(height: 15),
            // TextField(
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.red)),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(color: Colors.black, width: 1.0),
            //     ),
            //     labelText: ' Salary:',
            //     labelStyle: TextStyle(color: Colors.black),
            //     hintText: "Enter Developer's salary :",
            //   ),
            //   onChanged: (value) {
            //     // setState(() {
            //     //   salary = value;
            //     // });
            //   },
            // ),
            OutlinedButton(
                onPressed: () {
                  Api.saveDeveloper(
                    Developer(
                      name: DeveloperName,
                    ),
                  );
                  Get.to(Developers());
                },
                child: Text("Add"))
          ])),
    );
  }
}
