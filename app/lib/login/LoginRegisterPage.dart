import 'package:flutter/material.dart';
import 'Authentication.dart';

class LoginRegisterPage extends StatefulWidget {

  LoginRegisterPage({
    this.auth, this.onSignedIn
  });
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType {
  login,
  register,
}

class _LoginRegisterState extends State<LoginRegisterPage> {
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  bool validateAndSave() {
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if(validateAndSave()) {
      try {
        if(_formType == FormType.login) {
          String userId = await widget.auth.signIn(_email, _password);
          print('Login userId = ' + userId);
        } else {
          String userId = await widget.auth.signUp(_email, _password);
          print('Register userId = ' + userId);
        }
        widget.onSignedIn();
      }catch(e){
        print("Error = " + e.toString());
      }
    }
  }


  void moveToRegister() {
    formKey.currentState.reset();

    setState(()
    {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(()
    {
      _formType = FormType.login;
    });
  }

  //Design

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: new AppBar(
        title: new Text("Friday - Virtual Assistant"),
        backgroundColor: Colors.purple,
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form (
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return[
      CartImage(),
      new TextFormField(
        decoration: new InputDecoration(
          labelText: "Email",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        validator: (value){
          return value.isEmpty ? 'Email is required.' : null;
        },
        onSaved: (value){
          return _email = value;
        },
      ),

      SizedBox(height: 10.0,),

      new TextFormField(
        decoration: new InputDecoration(
          labelText: "Password",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        obscureText: true,
        validator: (value){
          return value.isEmpty ? 'Password is required.' : null;
        },
        onSaved: (value){
          return _password = value;
        },
      ),

      SizedBox(height: 20.0,),
    ];
  }

  List<Widget> createButtons() {
    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login' ,style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.orange,
          onPressed: validateAndSubmit,
        ),

        new FlatButton(
          child: new Text('Create Account',style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.red,
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text('Create Account' ,style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),

        new FlatButton(
          child: new Text('Already have an Account? Login',style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.red,
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}

class CartImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    AssetImage assetImage = AssetImage('images/social_cart.png');
    Image image = Image(image: assetImage, width: 100.0, height: 100.0,);
    return Container(child: image,);
  }
}