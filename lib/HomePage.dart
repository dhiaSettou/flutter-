import 'dart:convert';

import 'package:get/get.dart';
import 'package:projectsmangment/SelectProject.dart';
import 'package:projectsmangment/UserView.dart';
import 'package:projectsmangment/facture.dart';

import 'NewProject.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:projectsmangment/model/Project.dart';

import 'model/Configuration.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Project> projects = [];
  Future? futurePost;

  bool? newval = false;
  @override
  void initState() {
    super.initState();
    futurePost = getProjects();
  }

  getProjects() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip+"/project/get"));
    if (response.statusCode == 200) {
      projects = (json.decode(response.body) as List)
          .map((e) => Project.fromJson(e))
          .toList();
    } else {
      throw Exception('Cant not load this post');
    }
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String dropdownValue = 'One';

  void showbutton(context, int selectedDay) {
    showModalBottomSheet(
      backgroundColor: Color(0xFF737373),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0))),
              height: 400,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Select Projects'),
                          FloatingActionButton(
                            mini: true,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewProject()),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //       itemCount: projects.length,
                      //       itemBuilder: (context, index) {
                      //         return CheckboxListTile(
                      //           value: projects[index].isSelecte,
                      //           onChanged: (value) {
                      //             setModalState(() {
                      //               projects[index].isSelecte = value;
                      //             });
                      //           },
                      //           title: Text(projects[index].name ?? ""),
                      //         );
                      //       }),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            child: const Text('Delete'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/sllogo.png"),
                  ),
                ),
                child: Text(''),
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard_customize,
                  color: Colors.white,
                ),
                tileColor: Colors.deepPurple,
                title: const Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onTap: () {
                  Get.to(SelectProject());
                },
              ),
              SizedBox(height: 5),
              ListTile(
                leading: Icon(
                  Icons.calculate,
                  color: Colors.white,
                ),
                tileColor: Colors.deepPurple,
                title: const Text(
                  'Facture',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onTap: () {
                  Get.to(Facture());
                },
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: TableCalendar(
        weekendDays: [
          DateTime.friday,
        ],
        headerStyle: HeaderStyle(formatButtonVisible: false),
        firstDay: DateTime.utc(2021, 01, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
          Get.to(() => UserView());
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
