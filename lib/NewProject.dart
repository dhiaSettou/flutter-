import 'dart:ui';
import 'package:get/get.dart';
import 'package:projectsmangment/UserView.dart';
import 'package:projectsmangment/model/Project.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'Api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProject extends StatefulWidget {
  @override
  _NewProjectState createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  void changeColor(Color color) => setState(() => currentColor = color);
  Color currentColor = Color(0xff443a49);

  Color pickerColor = Color(0xff443a49);

  bool isSwitched = false;
  String? projectName;
  String? note;

  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Project"),
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
                labelText: 'Project name :',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter Project name :',
              ),
              onChanged: (value) {
                setState(() {
                  projectName = value;
                });
              },
            ),
            SizedBox(height: 15),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0),
                  ),
                  labelText: 'notes : ',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Add note for employees :'),
              onChanged: (value) {
                setState(() {
                  note = value;
                });
              },
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Save"),
                                ),
                              ],
                              titlePadding: const EdgeInsets.all(50.0),
                              contentPadding: const EdgeInsets.all(8.0),
                              content: SingleChildScrollView(
                                child: MaterialPicker(
                                  pickerColor: currentColor,
                                  onColorChanged: changeColor,
                                  enableLabel: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: currentColor, shape: BoxShape.circle),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Save"),
                                ),
                              ],
                              titlePadding: const EdgeInsets.all(0.0),
                              contentPadding: const EdgeInsets.all(0.0),
                              content: SingleChildScrollView(
                                child: MaterialPicker(
                                  pickerColor: currentColor,
                                  onColorChanged: changeColor,
                                  enableLabel: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text("Pick a Color For The Projcet"),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text('Visible For Employees :'),
                Switch(
                    activeColor: Colors.deepPurple,
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    })
              ],
            ),
            OutlinedButton(
                onPressed: () {
                  Api.saveProject(
                    Project(
                        name: projectName,
                        color: currentColor.value.toString(),
                        note: note),
                  );
                  Get.to(UserView());
                },
                child: Text("Add"))
          ])),
    );
  }
}
