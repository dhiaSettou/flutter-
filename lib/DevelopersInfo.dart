import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectsmangment/model/Configuration.dart';

import 'model/Developer.dart';
import 'model/Project.dart';
import 'model/ProjectDeveloper.dart';
import 'model/Salary.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectsmangment/NewDeveloper.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/Project.dart';
import 'package:projectsmangment/model/Salary.dart';
import 'DevelopersInfo.dart';
import 'model/Configuration.dart';

class DevelopersInfo extends StatefulWidget {
  const DevelopersInfo({Key? key}) : super(key: key);

  @override
  _DevelopersInfoState createState() => _DevelopersInfoState();
}

class _DevelopersInfoState extends State<DevelopersInfo> {
  List<Salary> salary = [];
  //  Get.arguments نهزو  من الباجة لوخرة ونحطوه في متغير فلباجة لوخرة
  Developer developer = Get.arguments;
  bool isswitched = false;
  List<Project> projects = [];
  List<Developer> developers = [];
  List<ProjectDeveloper> projectDeveloper = [];

  getSalary() async {
    http.Response response = await http.get(
        Uri.parse(Configuration.ip + "/salary/getSalaryById/${developer.id}"));
    if (response.statusCode == 200) {
      salary = (json.decode(response.body) as List)
          .map((e) => Salary.fromJson(e))
          .toList();
    } else {
      throw Exception('Cant not load this post');
    }
  }

  getDeveloeprs() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip + "/developer/get"));
    if (response.statusCode == 200) {
      developers = (json.decode(response.body) as List)
          .map((e) => Developer.fromJson(e))
          .toList();
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeveloeprs();
    print(Get.arguments);
    getSalary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          title: Text("Developer Information"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: salary.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text("Salary : ${salary[index].salary.toString()}"),
                          Icon(Icons.monetization_on_sharp)
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              "Started At: ${DateFormat('yyyy-MM-dd').format(salary[index].startsAt!).toString()}"),
                          Icon(Icons.date_range)
                        ],
                      ),
                    ],
                  )),
                );
              }),
        )));
  }
}
// arguments:projectDeveloper[index]