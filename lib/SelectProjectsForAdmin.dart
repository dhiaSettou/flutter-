import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projectsmangment/NewProject.dart';
import 'package:projectsmangment/AdminView.dart';
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'Api.dart';
import 'model/Configuration.dart';
import 'model/Project.dart';

class SelectProjectsForAdmin extends StatefulWidget {
  const SelectProjectsForAdmin({Key? key}) : super(key: key);

  @override
  _SelectProjectsForAdminState createState() => _SelectProjectsForAdminState();
}

class _SelectProjectsForAdminState extends State<SelectProjectsForAdmin> {
  DateTime? now = Get.arguments;

  bool isswitched = false;
  List<ProjectDeveloper> projects = [];
  // List<Project> projects = [];

  Future? futurePost;
  @override
  void initState() {
    super.initState();
    // getProjects();
    getProjectsById();
  }

  // getProjects() async {
  //   http.Response response =
  //       await http.get(Uri.parse('http://192.168.1.105:9097/project/get'));
  //   if (response.statusCode == 200) {
  //     projects = (json.decode(response.body) as List)
  //         .map((e) => Project.fromJson(e))
  //         .toList();
  //     setState(() {});
  //   } else {
  //     throw Exception('Cant not load this post');
  //   }
  // }

  getProjectsById() async {
    http.Response response = await http.get(
        Uri.parse(Configuration.ip + "/projectdeveloper/getByDeveloperId/15"));
    if (response.statusCode == 200) {
      projects = (json.decode(response.body) as List)
          .map((e) => ProjectDeveloper.fromJson(e))
          .toList();
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Select Project Of The Day "),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ExpansionPanelList(
                          expandedHeaderPadding: EdgeInsets.all(0),
                          animationDuration: Duration(milliseconds: 850),
                          children: [
                            ExpansionPanel(
                              backgroundColor: Color(int.parse(
                                  projects[index].project!.color ??
                                      "4294967295")),
                              headerBuilder: (context, isExpanded) {
                                return projects[index].isExpended ?? true
                                    ? ListTile(
                                        title: Text(
                                            projects[index].project!.name ??
                                                "No Name"),
                                        subtitle: InkWell(
                                            onTap: () {},
                                            child: Text(
                                              "Details",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline),
                                            )),
                                      )
                                    : ListTile(
                                        title: Text(
                                            projects[index].project!.name ??
                                                "No Name"),
                                      );
                              },
                              body: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, bottom: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('Full Day'),
                                            Switch(
                                                value: projects[index]
                                                        .fullDay ??
                                                    true, // ?? means if null ;
                                                onChanged: (value) {
                                                  projects[index].fullDay =
                                                      value;
                                                  setState(() {});
                                                }),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                if (projects[index].fullDay!) {
                                                  Api.saveProjectDeveloper(
                                                      ProjectDeveloper(
                                                    id_Developer: 7,
                                                    id_Project: projects[index]
                                                        .id_Project,
                                                    fullDay:
                                                        projects[index].fullDay,
                                                    startedTime: DateTime(
                                                        now!.year,
                                                        now!.month,
                                                        now!.day,
                                                        08,
                                                        00,
                                                        00),
                                                    finishedTime: DateTime(
                                                        now!.year,
                                                        now!.month,
                                                        now!.day,
                                                        16,
                                                        00,
                                                        00),
                                                  )).then((value) => Get.to(
                                                      () => AdminView()));
                                                } else {
                                                  Api.saveProjectDeveloper(
                                                          ProjectDeveloper(
                                                              id_Developer: 7,
                                                              id_Project:
                                                                  projects[
                                                                          index]
                                                                      .id_Project,
                                                              fullDay: projects[
                                                                      index]
                                                                  .fullDay,
                                                              startedTime:
                                                                  projects[
                                                                          index]
                                                                      .startedTime,
                                                              finishedTime:
                                                                  projects[
                                                                          index]
                                                                      .finishedTime))
                                                      .then((value) => Get.to(
                                                          () => AdminView()));
                                                }
                                              },
                                              child: Text("Save"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    /* if(projects[index].fullDay)
                                      {nothing}
                                      else{row([....])};
                                      */
                                    projects[index].fullDay ?? true
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  timeFrom(
                                                      projects[index], context);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 0.09),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text("   From :  "),
                                                      Text(DateFormat('hh:mm')
                                                              .format(projects[
                                                                          index]
                                                                      .startedTime ??
                                                                  DateTime
                                                                      .now())
                                                              .toString() +
                                                          '    '),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  timeTo(
                                                      projects[index], context);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 0.09),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text("   To :   "),
                                                      Text(DateFormat('kk:mm')
                                                              .format(projects[
                                                                          index]
                                                                      .finishedTime ??
                                                                  DateTime
                                                                      .now())
                                                              .toString() +
                                                          '   '),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                              ),
                              isExpanded: projects[index].isExpended!,
                              canTapOnHeader: true,
                            ),
                          ],
                          dividerColor: Colors.grey,
                          expansionCallback: (panelIndex, isExpanded) {
                            setState(() {
                              /*  if else normal statment 
                              we change the value of projects[index].isExpended , when it's flase it collase - when it's true is expend by using expansionCallback;  */
                              projects[index].isExpended =
                                  projects[index].isExpended == true
                                      ? false
                                      : true;
                            });
                          },
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 4,
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(NewProject());
        },
      ),
    );
  }

  timeFrom(ProjectDeveloper projectDeveloper, context) {
    DatePicker.showTimePicker(context,
        showTitleActions: true,
        showSecondsColumn: false,
        onChanged: (date) {}, onConfirm: (date) {
      print('confirm $date');
      // put the picked time in a variable
      projectDeveloper.startedTime = date;
      setState(() {});
    }, currentTime: Get.arguments);
  }

  timeTo(ProjectDeveloper projectDeveloper, context) {
    DatePicker.showTimePicker(context,
        showTitleActions: true,
        showSecondsColumn: false,
        onChanged: (date2) {}, onConfirm: (date2) {
      print('confirm $date2');
      projectDeveloper.finishedTime = date2;
      setState(() {});
    }, currentTime: Get.arguments);
  }
}
