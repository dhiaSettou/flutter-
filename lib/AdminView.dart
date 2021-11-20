import 'dart:ui';
import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:projectsmangment/AppHomePage.dart';
import 'package:projectsmangment/SelectProjectsForAdmin.dart';
import 'package:projectsmangment/UserView.dart';
import 'package:projectsmangment/dhia.dart';
import 'package:projectsmangment/model/Configuration.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'Facture.dart';
import 'SelectProject.dart';
import 'UserView.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/Project.dart';

/// The app which hosts the home page which contains the calendar on it.
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Calendar Demo', home: AdminView());
  }
}

/// The hove page which hosts the calendar
class AdminView extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const AdminView({Key? key}) : super(key: key);

  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  bool isswitched = false;
  List<ProjectDeveloper> projectDevelopers = [];
  List<Appointment> appointments = [];
  List<Developer> developers = [];

  Future? futurePost;
  @override
  void initState() {
    super.initState();
    getDeveloeprs();
    getProjectsById();
  }

  getProjectsById() async {
    http.Response response = await http
        .get(Uri.parse(Configuration.ip+"/projectdeveloper/get"));
    if (response.statusCode == 200) {
      projectDevelopers = (json.decode(response.body) as List)
          .map((e) => ProjectDeveloper.fromJson(e))
          .toList();

      _getDataSource();
/* filter with finishedTime */
      projectDevelopers = projectDevelopers
          .where((element) => element.finishedTime != null)
          .toList();
      for (var i = 0; i < projectDevelopers.length; i++) {
        appointments.add(Appointment(
          startTime: projectDevelopers[i].startedTime!,
          endTime: projectDevelopers[i].finishedTime!,
          subject: projectDevelopers[i].project!.name!,
          color: Color(int.parse(projectDevelopers[i].project!.color!)),
          resourceIds: projectDevelopers[i].resourceIds!,
        ));
      }
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  getDeveloeprs() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip+"/developer/get"));
    if (response.statusCode == 200) {
      developers = (json.decode(response.body) as List)
          .map((e) => Developer.fromJson(e))
          .toList();

      for (var i = 0; i < developers.length; i++) {
        resources.add(CalendarResource(
            id: developers[i].id!, displayName: developers[i].name!));
      }

      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  List<CalendarResource> resources = <CalendarResource>[];

  DataSource _getCalendarDataSource() {
    // List<ProjectDeveloper> appointments = <ProjectDeveloper>[];
    // List<CalendarResource> resources = <CalendarResource>[];

    // resources
    //     .add(CalendarResource(displayName: 'John', id: '1', color: Colors.red));
    // resources.add(
    //     CalendarResource(displayName: 'John', id: '0002', color: Colors.red));
    // resources.add(
    //     CalendarResource(displayName: 'John', id: '0001', color: Colors.red));
    return DataSource(appointments, resources);
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
          actions: [
            BackButton(
              onPressed: () {
                Get.to(AppHomePage());
              },
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text("Select Project Of The Day "),
        ),
        body: SafeArea(
          child: SfCalendar(
            resourceViewSettings: ResourceViewSettings(
                displayNameTextStyle: TextStyle(color: Colors.white),
                showAvatar: false,
                size: 80,
                visibleResourceCount: 5),

            showNavigationArrow: true,
            // showWeekNumber: true,
            view: CalendarView.timelineMonth,

            dataSource: _getCalendarDataSource(),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          ),
        ));
  }

  DataSource _getDataSource() {
    return DataSource(appointments, resources);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}
// class DataSource extends CalendarDataSource {
//   DataSource(
//       List<ProjectDeveloper> source, List<CalendarResource> resourceColl) {
//     appointments = source;
//     resources = resourceColl;
//   }
// }

  // @override
  // String getSubject(int index) {
  //   return _getProjectData(index).project!.name!;
  // }

  // @override
  // Color getColor(int index) {
  //   return Color(
  //       int.parse(_getProjectData(index).project!.color ?? "4282661449"));
  // }

  // @override
  // DateTime getStartTime(int index) {
  //   return _getProjectData(index).startedTime!;
  // }

  // @override
  // DateTime getEndTime(int index) {
  //   return _getProjectData(index).finishedTime!;
  // }

  // @override
  // bool isAllDay(int index) {
  //   return _getProjectData(index).fullDay ?? true;
  // }

  // // @override
  // // DateTime day(int index) {
  // //   return appointments![index].date;
  // // }

  // ProjectDeveloper _getProjectData(int index) {
  //   final dynamic project = appointments![index];
  //   late final ProjectDeveloper meetingData;
  //   if (project is ProjectDeveloper) {
  //     meetingData = project;
  //   }

  //   return meetingData;
  // }
  //
// }
