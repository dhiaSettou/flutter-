import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projectsmangment/AddTask.dart';
import 'package:projectsmangment/NewProject.dart';
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'package:projectsmangment/AppHomePage.dart';
import 'Api.dart';
import 'model/Configuration.dart';
import 'model/Project.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final myController = TextEditingController();

  DateTime? _dateFrom;
  DateTime? _dateTo;

  DateTime? now = Get.arguments;

  bool isswitched = false;
  List<ProjectDeveloper> projectDeveloper = [];
  // List<Project> projects = [];

  Future? futurePost;
  @override
  void initState() {
    super.initState();
    // getProjects();
    getProjectsById();
  }

  getProjectsById() async {
    http.Response response = await http.get(
        Uri.parse(Configuration.ip + "/projectdeveloper/getByDeveloperId/1"));
    if (response.statusCode == 200) {
      projectDeveloper = (json.decode(response.body) as List)
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
                    itemCount: projectDeveloper.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ExpansionPanelList(
                          expandedHeaderPadding: EdgeInsets.all(0),
                          animationDuration: Duration(milliseconds: 850),
                          children: [
                            ExpansionPanel(
                              backgroundColor: Color(int.parse(
                                  projectDeveloper[index].project!.color ??
                                      "4294967295")),
                              headerBuilder: (context, isExpanded) {
                                return projectDeveloper[index].isExpended ??
                                        true
                                    ? ListTile(
                                        title: Text(projectDeveloper[index]
                                                .project!
                                                .name ??
                                            "No Name"),
                                        subtitle: InkWell(
                                            onTap: () {
                                              Get.to(AddTask(),
                                                  arguments:
                                                      projectDeveloper[index]);
                                            },
                                            child: Text(
                                              "Add today's Task +",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline),
                                            )),
                                      )
                                    : ListTile(
                                        title: Text(projectDeveloper[index]
                                                .project!
                                                .name ??
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
                                                value: projectDeveloper[index]
                                                        .fullDay ??
                                                    true, // ?? means if null ;
                                                onChanged: (value) {
                                                  projectDeveloper[index]
                                                      .fullDay = value;
                                                  setState(() {});
                                                }),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                if (projectDeveloper[index]
                                                    .fullDay!) {
                                                  if (_dateFrom == null &&
                                                      _dateTo == null) {
                                                    Api.saveProjectDeveloper(
                                                        ProjectDeveloper(
                                                      id_Developer: 1,
                                                      id_Project:
                                                          projectDeveloper[
                                                                  index]
                                                              .id_Project,
                                                      fullDay: projectDeveloper[
                                                              index]
                                                          .fullDay,
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
                                                        () => AppHomePage()));
                                                  } else {
                                                    Api.saveProjectDeveloper(
                                                        ProjectDeveloper(
                                                      id_Developer: 1,
                                                      id_Project:
                                                          projectDeveloper[
                                                                  index]
                                                              .id_Project,
                                                      fullDay: projectDeveloper[
                                                              index]
                                                          .fullDay,
                                                      startedTime: DateTime(
                                                          _dateFrom!.year,
                                                          _dateFrom!.month,
                                                          _dateFrom!.day,
                                                          08,
                                                          00,
                                                          00),
                                                      finishedTime: DateTime(
                                                          _dateTo!.year,
                                                          _dateTo!.month,
                                                          _dateTo!.day,
                                                          16,
                                                          00,
                                                          00),
                                                    )).then((value) => Get.to(
                                                        () => AppHomePage()));
                                                    ;
                                                  }
                                                } else {
                                                  Api.saveProjectDeveloper(ProjectDeveloper(
                                                          id_Developer: 1,
                                                          id_Project:
                                                              projectDeveloper[
                                                                      index]
                                                                  .id_Project,
                                                          fullDay:
                                                              projectDeveloper[
                                                                      index]
                                                                  .fullDay,
                                                          startedTime:
                                                              projectDeveloper[
                                                                      index]
                                                                  .startedTime,
                                                          finishedTime:
                                                              projectDeveloper[
                                                                      index]
                                                                  .finishedTime))
                                                      .then((value) => Get.to(
                                                          () => AppHomePage()));
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
                                    projectDeveloper[index].fullDay ?? true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2021),
                                                          lastDate:
                                                              DateTime(2022))
                                                      .then((date) {
                                                    setState(() {
                                                      _dateFrom = date;
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 0.09),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(_dateFrom == null
                                                          ? '   Date From :   '
                                                          : DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  _dateFrom!)
                                                              .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2021),
                                                          lastDate:
                                                              DateTime(2022))
                                                      .then((date) {
                                                    setState(() {
                                                      _dateTo = date;
                                                    });
                                                  });
                                                },
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 0.09),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(_dateTo == null
                                                          ? '   Date To :   '
                                                          : DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(_dateTo!)
                                                              .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  timeFrom(
                                                      projectDeveloper[index],
                                                      context);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 0.09),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text("    Time From :  "),
                                                      Text(DateFormat('hh:mm')
                                                              .format(projectDeveloper[
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
                                                      projectDeveloper[index],
                                                      context);
                                                },
                                                child: Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 0.09),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text("    Time To :   "),
                                                      Text(DateFormat('kk:mm')
                                                              .format(projectDeveloper[
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
                                          ),
                                  ],
                                ),
                              ),
                              isExpanded: projectDeveloper[index].isExpended!,
                              canTapOnHeader: true,
                            ),
                          ],
                          dividerColor: Colors.grey,
                          expansionCallback: (panelIndex, isExpanded) {
                            setState(() {
                              /*  if else normal statment 
                              we change the value of projects[index].isExpended , when it's flase it collapse - when it's true is expend by using expansionCallback;  */
                              projectDeveloper[index].isExpended =
                                  projectDeveloper[index].isExpended == true
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
