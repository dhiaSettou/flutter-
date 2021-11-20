import 'dart:ui';
import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:projectsmangment/AdminView.dart';
import 'package:projectsmangment/Developers.dart';
import 'package:projectsmangment/UserView.dart';
import 'package:projectsmangment/dhia.dart';
import 'package:projectsmangment/model/Configuration.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Facture.dart';
import 'SelectProject.dart';
import 'SelectProjectsForAdmin.dart';
import 'UserView.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/Project.dart';

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: AppHomePage());
  }
}

/// The hove page which hosts the calendar
class AppHomePage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const AppHomePage({Key? key}) : super(key: key);

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  List<ProjectDeveloper> projectDevelopers = [];

  Future? futurePost;
  @override
  void initState() {
    super.initState();
    getProjectsById();
  }

  getProjectsById() async {
    // 'ip/projectdeveloper/getCalenderByDeveloperId/14'
    http.Response response = await http.get(Uri.parse(
        Configuration.ip + "projectdeveloper/getCalenderByDeveloperId/1"));
    if (response.statusCode == 200) {
      projectDevelopers = (json.decode(response.body) as List)
          .map((e) => ProjectDeveloper.fromJson(e))
          .toList();

/* filter with finishedTime */
      projectDevelopers = projectDevelopers
          .where((element) => element.finishedTime != null)
          .toList();

      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
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
                ListTile(
                  leading: Icon(
                    Icons.calculate,
                    color: Colors.white,
                  ),
                  tileColor: Colors.deepPurple,
                  title: const Text(
                    'ControLView',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () {
                    Get.to(AdminView());
                  },
                ),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(
                    Icons.emoji_people_outlined,
                    color: Colors.white,
                  ),
                  tileColor: Colors.deepPurple,
                  title: const Text(
                    'Developers',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () {
                    Get.to(Developers());
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text("Select Project Of The Day "),
        ),
        body: SafeArea(
          child: SfCalendar(
            onTap: (CalendarTapDetails tapDetails) {
              Get.to(UserView(), arguments: tapDetails.date);
            },
            showNavigationArrow: true,
            // showWeekNumber: true,
            view: CalendarView.month,

            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          ),
        ));
  }

  List<ProjectDeveloper> _getDataSource() {
    return projectDevelopers;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<ProjectDeveloper> source) {
    appointments = source;
  }

  @override
  String getSubject(int index) {
    return _getProjectData(index).project!.name!;
  }

  @override
  Color getColor(int index) {
    return Color(
        int.parse(_getProjectData(index).project!.color ?? "4282661449"));
  }

  @override
  DateTime getStartTime(int index) {
    return _getProjectData(index).startedTime!;
  }

  @override
  DateTime getEndTime(int index) {
    return _getProjectData(index).finishedTime!;
  }

  @override
  bool isAllDay(int index) {
    return _getProjectData(index).fullDay ?? true;
  }

  ProjectDeveloper _getProjectData(int index) {
    final dynamic projectDevelopers = appointments![index];
    late final ProjectDeveloper meetingData;
    if (projectDevelopers is ProjectDeveloper) {
      meetingData = projectDevelopers;
    }

    return meetingData;
  }
}
