import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projectsmangment/NewProject.dart';
import 'package:projectsmangment/model/Configuration.dart';
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'package:projectsmangment/model/Task.dart';
import 'Api.dart';
import 'model/Project.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final myController = TextEditingController();
  final Controller = TextEditingController();

  bool isswitched = false;
  List<Task> tasks = [];

  Future? futurePost;
  ProjectDeveloper projectDeveloper = Get.arguments;

  List<Project> projects = [];
  @override
  void initState() {
    super.initState();
    // getProjectsById();
    // getProjectsById();
  }

  getTask() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip + "/task/get"));
    if (response.statusCode == 200) {
      tasks = (json.decode(response.body) as List)
          .map((e) => Task.fromJson(e))
          .toList();
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  // getProjectsById() async {
  //   http.Response response = await http.get(Uri.parse(
  //       'http://192.168.1.105:9097/projectdeveloper/getByDeveloperId/14'));
  //   if (response.statusCode == 200) {
  //     projectDeveloper = (json.decode(response.body) as List)
  //         .map((e) => ProjectDeveloper.fromJson(e))
  //         .toList();
  //     setState(() {});
  //   } else {
  //     throw Exception('Cant not load this post');
  //   }
  // }
  //   getProjectsById() async {
  //   http.Response response = await http.get(Uri.parse(
  //       'http://192.168.1.105:9097/projectdeveloper/getByDeveloperId/14'));
  //   if (response.statusCode == 200) {
  //     projectDeveloper = (json.decode(response.body) as List)
  //         .map((e) => ProjectDeveloper.fromJson(e))
  //         .toList();
  //     setState(() {});
  //   } else {
  //     throw Exception('Cant not load this post');
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Today's Task "),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  labelText: 'Task :',
                  hintStyle: TextStyle(color: Colors.deepPurple),
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  hintText: 'Add  a Task For Todaday :',
                ),
                onChanged: (value) {},
              ),
              ElevatedButton(
                onPressed: () async {
                  Task task = await Api.saveTask(Task(
                    description: myController.text,
                    projectDeveloperId: Get.arguments.id,
                  ));
                  print(Get.arguments);
                  projectDeveloper.tasks!.add(task);
                  setState(() {});
                },
                child: Text("Save"),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: projectDeveloper.tasks!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.grey[50],
                          title: Text(
                              " task :  ${projectDeveloper.tasks![index].description ?? "Nothing"}"),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
