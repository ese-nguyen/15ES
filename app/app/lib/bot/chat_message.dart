import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget{
  final String name;
  final String text;

  ChatMessage({this.name, this.text});

  Widget _buildChild(BuildContext context) {
    if(name == "Me") {
      return new Container (
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(
                child: new Text(name[0]),
              ),
            ),
            Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Divider(),
                  new Text(name, style: Theme.of(context).textTheme.subhead,),
                  //new Text(name, style: TextStyle(color: Colors.red.withOpacity(0.8)) ,),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  )
                ],
              ),
            ),
          ],
        ),
      );
      //-------------------------------------------------//
    } else if(name == "Bot") {
      return new Container (
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Divider(),
                  new Text(name,  style: Theme.of(context).textTheme.subhead,),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: new CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: new Text(name[0],  style: TextStyle(color: Colors.black),),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(child: _buildChild(context));
  }

}
