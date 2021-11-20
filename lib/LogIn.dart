import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectsmangment/Api.dart';
import 'package:projectsmangment/HomePage.dart';
import 'package:projectsmangment/SignUp.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:http/http.dart' as http;
import 'package:projectsmangment/model/ProjectDeveloper.dart';
import 'package:projectsmangment/AppHomePage.dart';

import 'model/Configuration.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final myController = TextEditingController();
  List<Developer> devo = [];

  List<Developer> developers = [];

  var developer_name;
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

  getDeveloeprsById() async {
    http.Response response =
        await http.get(Uri.parse(Configuration.ip + "/developer/get"));
    if (response.statusCode == 200) {
      devo = (json.decode(response.body) as List)
          .map((e) => Developer.fromJson(e))
          .toList();
      setState(() {});
    } else {
      throw Exception('Cant not load this post');
    }
  }

  @override
  void initState() {
    super.initState();
    getDeveloeprs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developer Log In "),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width: 5),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/sllogo.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: 250,
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                    labelText: 'UserName :',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    ),
                    hintStyle: TextStyle(color: Colors.deepPurple),
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    hintText: 'Enter Your UserName :',
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.elliptical(0, 0)),
                    ),
                    labelText: 'Password :',
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: Colors.deepPurple,
                    ),
                    hintStyle: TextStyle(color: Colors.deepPurple),
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    hintText: 'Enter Your Password :',
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: OutlinedButton(
                  onPressed: () {
                    Get.to(AppHomePage());
                    // Api.saveDeveloper(Developer(userNamer: myController.text));
                  },
                  child: Text("Log In"),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(LogIn());
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  "Sign Up Here !",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.deepPurple),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
