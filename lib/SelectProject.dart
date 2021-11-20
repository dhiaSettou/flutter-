import 'dart:ui';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projectsmangment/model/Configuration.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/Project.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'package:projectsmangment/AppHomePage.dart';

import 'Api.dart';
import 'model/Project.dart';

class SelectProject extends StatefulWidget {
  @override
  _SelectProjectState createState() => _SelectProjectState();
}

class _SelectProjectState extends State<SelectProject> {
  List<Developer> developers = [];
  List<Project> projects = [];

  String? _mySelection;

  bool? _value = false;
  @override
  void initState() {
    super.initState();
    getDeveloeprs();
    getProjects();
  }

  getDeveloeprs() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip+"/developer/get"));
    if (response.statusCode == 200) {
      developers = (json.decode(response.body) as List)
          .map((e) => Developer.fromJson(e))
          .toList();
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  getProjects() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip+"project/get"));
    if (response.statusCode == 200) {
      projects = (json.decode(response.body) as List)
          .map((e) => Project.fromJson(e))
          .toList();
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          title: Text("DashBoard"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.deepPurple)),
                child: Row(
                  children: [
                    Text("  Select Project For : "),
                    Container(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.grey[50],
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 15),
                        isDense: true,
                        hint: new Text(
                          "Select Developer",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        value: _mySelection,
                        onChanged: (newValue) {
                          setState(() {
                            _mySelection = newValue;
                          });
                        },
                        /* we use .map to convert anything we want  it takes a function as a parameter / we use it also when we want only one thing from the object /like only age from object ahmed from class person - items: returns  DropdownMenuItem of type STRING ,  */
                        items: developers.map((Developer developer) {
                          return new DropdownMenuItem<String>(
                            /* search by name to get the id for posting */
                            value: developer.id.toString(),
                            child: new Text(
                              developer.name ?? "No Name",
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CheckboxListTile(
                        tileColor: Color(
                            int.parse(projects[index].color ?? "4294967295")),
                        title: Text(projects[index].name ?? "No Name"),
                        value: projects[index].isSelected,
                        onChanged: (value) {
                          setState(() {
                            projects[index].isSelected = value;
                          });
                        },
                      ),
                    );
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                for (var i = 0; i < projects.length; i++) {
                  if (projects[i].isSelected == true) {
                    Api.saveProjectDeveloper(ProjectDeveloper(
                      id_Developer: int.tryParse(_mySelection!),
                      id_Project: projects[i].id,
                    ));
                  }
                }
                ;
                Get.to(AppHomePage());
              },
              child: Text("Save"),
            ),
          ],
        ));
  }
}
