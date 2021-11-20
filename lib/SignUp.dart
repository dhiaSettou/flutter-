import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
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
                    labelText: 'Developer :',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    ),
                    hintStyle: TextStyle(color: Colors.deepPurple),
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    hintText: 'Enter Your Name :',
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
                  onPressed: () {},
                  child: Text("Log In"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                "Sign Up Here !",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.deepPurple),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
