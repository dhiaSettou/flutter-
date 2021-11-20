import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectsmangment/LogIn.dart';
import 'package:projectsmangment/UserView.dart';
import 'package:projectsmangment/AdminView.dart';
import 'package:projectsmangment/dhia.dart';
import 'package:projectsmangment/AppHomePage.dart';

import 'HomePage.dart';
import 'DateTimePicker.dart';
import 'SelectProject.dart';

void main() {
  runApp( new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: AppHomePage(),
    );
  }
}
