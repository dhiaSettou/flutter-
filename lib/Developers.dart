import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectsmangment/Api.dart';
import 'package:projectsmangment/NewDeveloper.dart';
import 'package:projectsmangment/SetSalary.dart';
import 'package:projectsmangment/model/Developer.dart';
import 'package:projectsmangment/model/Project.dart';
import 'package:projectsmangment/model/Salary.dart';
import 'DevelopersInfo.dart';
import 'model/Configuration.dart';
import 'model/ProjectDeveloper.dart';

class Developers extends StatefulWidget {
  const Developers({Key? key}) : super(key: key);

  @override
  _DevelopersState createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
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

  bool isswitched = false;
  List<Project> projects = [];
  List<Developer> developers = [];
  List<Salary> salary = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeveloeprs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Developers"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: developers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.grey,
                        title: Text(developers[index].name!),
                        trailing: SizedBox(
                          width: 150,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(DevelopersInfo(),
                                        arguments: developers[index]);
                                  },
                                  icon: Icon(Icons.money)),
                              IconButton(
                                  onPressed: () {
                                    Get.to(SetSalary(),
                                        arguments: developers[index]);
                                    ;
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                content: const Text(
                                                    'are you sure you want to delete this developer ?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                      child:
                                                          const Text('Confirm'),
                                                      onPressed: () {
                                                        Api.deleteDeveloper(
                                                            developers[index]
                                                                .id!);
                                                        Navigator.pop(
                                                            context, 'Confirm');
                                                        setState(() {
                                                          developers.remove(
                                                              developers[
                                                                  index]);
                                                        });
                                                      }),
                                                ]));
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    FloatingActionButton.small(
                        child: Icon(Icons.add),
                        onPressed: () {
                          Get.to(NewDeveloper());
                          ;
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
