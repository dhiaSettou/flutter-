import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projectsmangment/NewProject.dart';
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'package:projectsmangment/model/Salary.dart';
import 'Api.dart';
import 'model/Configuration.dart';
import 'model/Developer.dart';
import 'model/Project.dart';

class Facture extends StatefulWidget {
  const Facture({Key? key}) : super(key: key);

  @override
  _FactureState createState() => _FactureState();
}

class _FactureState extends State<Facture> {
  bool isswitched = false;
  List<Project> projects = [];
  List<Developer> developers = [];
  List<Salary> salary = [];

  Future? futurePost;
  @override
  void initState() {
    super.initState();
    getDeveloeprs();
    getProjects();
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

  getProjects() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip + "/project/get"));
    if (response.statusCode == 200) {
      projects = (json.decode(response.body) as List)
          .map((e) => Project.fromJson(e))
          .toList();
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  // getProjectsById() async {
  //   http.Response response = await http.get(Uri.parse(
  //       'http://192.168.1.105:9097/projectdeveloper/getByDeveloperId/7'));
  //   if (response.statusCode == 200) {
  //     projects = (json.decode(response.body) as List)
  //         .map((e) => Project.fromJson(e))
  //         .toList();
  //     setState(() {});
  //   } else {
  //     throw Exception('Cant not load this post');
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" Facture "),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      subtitle: InkWell(
                          onTap: () {},
                          child: Text(
                            "Cost",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          )),
                      tileColor: Colors.grey,
                      title: Text(projects[index].name!),
                      trailing: SizedBox(
                        width: 150,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
