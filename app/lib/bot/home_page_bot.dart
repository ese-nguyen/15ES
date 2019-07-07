import 'chat_screen.dart';
import 'package:flutter/material.dart';

class HomePageBot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Friday"),
          backgroundColor: Colors.purple,
        ),
        body: new ChatScreen());
  }
}