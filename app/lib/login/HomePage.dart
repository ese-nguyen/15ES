import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'package:hackathon/bot/home_page_bot.dart';

class HomePage extends StatefulWidget {

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  HomePage({
    this.auth,
    this.onSignedOut,
  });

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
        backgroundColor: Colors.purple,
      ),
      body: new Container(
        child :Center(
            child:  new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  BotImage(),
                  new RaisedButton(
                    child: Text("Friday", style: TextStyle(fontSize: 20.0),),
                    textColor: Colors.white,
                    color: Colors.cyan,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePageBot()),
                      );
                    },
                  ),
                  Divider(),
                  ManageImage(),
                  new RaisedButton(
                    child: Text("Feature 2", style: TextStyle(fontSize: 20.0),),
                      textColor: Colors.white,
                      color: Colors.cyan,
                      onPressed: null,
                  ),
                ],
            ),
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.purple,
        child: new Container(
          margin: const EdgeInsets.only(left: 70.0, right: 70.0),
          child: new Row (
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new RaisedButton(
                child: Text("Log Out", style: TextStyle(fontSize: 20.0)),
                color: Colors.orange,
                onPressed: _logoutUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BotImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('images/bot.png');
    Image image = Image(image: assetImage, width: 150.0, height: 150.0,);
    return Container(child: image,);
  }
}

class ManageImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('images/group_manage.png');
    Image image = Image(image: assetImage, width: 150.0, height: 150.0,);
    return Container(child: image,);
  }
}