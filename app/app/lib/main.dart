import 'package:flutter/material.dart';
import 'login/Mapping.dart';
import 'login/Authentication.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friday - Virtual Assistant",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MappingPage(auth: Auth(),),
    );
  }
}