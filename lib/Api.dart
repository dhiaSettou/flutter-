import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/Project.dart';
import 'package:projectsmangment/model/Salary.dart';
import 'package:projectsmangment/model/Task.dart';

import 'model/Configuration.dart';
import 'model/ProjectDeveloper.dart';
import 'package:dio/dio.dart' as dio;

class Api {
  static Future<Project> saveProject(Project project) async {
    final Response response = await post(
        Uri.parse(Configuration.ip + "/project/save"),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: jsonEncode(project.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
      return Project.fromJson(json.decode(response.body));
    } else {
      ///print('Error');
      throw Exception("Can't load ");
    }
  }

  static Future<Developer> saveDeveloper(Developer developer) async {
    final Response response = await post(
        Uri.parse(Configuration.ip + "/developer/save"),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: jsonEncode(developer.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
      return Developer.fromJson(json.decode(response.body));
    } else {
      ///print('Error');
      throw Exception("Can't load ");
    }
  }

  static Future<ProjectDeveloper> saveProjectDeveloper(
      ProjectDeveloper projectDeveloper) async {
    try {
      // var dioRequest = dio.Dio();
      // try {
      //   dioRequest.options.headers['content-Type'] =
      //       'application/json;charset=UTF-8';
      //   final response = await dioRequest.post(
      //       "http://192.168.1.105:9097/projectdeveloper/save",
      //       data: projectDeveloper.toJson());
      //   if (response.statusCode == 200) {
      //     print(response.data);
      //   }
      // } on dio.DioError catch (ex) {
      //   if (ex.type == dio.DioErrorType.connectTimeout) {
      //     throw Exception("Connection Timeout Exception");
      //   }
      //   throw Exception(ex.error);
      // }
      final Response response = await post(
          Uri.parse(Configuration.ip + "/projectdeveloper/save"),
          headers: {'Content-Type': 'application/json;charset=UTF-8'},
          body: json.encode(projectDeveloper.toJson()));

      if (response.statusCode == 200) {
        print(response.body);
        return ProjectDeveloper.fromJson(json.decode(response.body));
      }

      ///print('Error');

    } catch (e) {
      throw e;
    }
    return ProjectDeveloper();
  }

  static Future<Task> saveTask(Task task) async {
    final Response response = await post(
        Uri.parse(Configuration.ip + "/task/save"),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: jsonEncode(task.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
      return Task.fromJson(json.decode(response.body));
    } else {
      ///print('Error');
      throw Exception("Can't load ");
    }
  }

  static Future<Salary> saveSalary(Salary salary) async {
    final Response response = await post(
        Uri.parse(Configuration.ip + "/salary/save"),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: jsonEncode(salary.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
      return Salary.fromJson(json.decode(response.body));
    } else {
      ///print('Error');
      throw Exception("Can't load ");
    }
  }

  static Future<Response> deleteDeveloper(int id) async {
    //business logic to send data to server
    final Response response = await delete(
        Uri.parse(Configuration.ip + "/developer/delete/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        });

    if (response.statusCode == 200) {
      //print(response.body);
      return response;
    } else {
      //print('Error');
      throw Exception("Can't load author");
    }
  }
}
