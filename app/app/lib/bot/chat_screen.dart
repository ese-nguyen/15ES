import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:speech_recognition/speech_recognition.dart';
import 'package:hackathon/camera/TakePicture.dart';

class ChatScreen extends StatefulWidget{
  @override
  State createState() => new ChatScreenState();
}

Future<List<String>> getData(String _textAPI) async {
  //String url = 'https://translation.googleapis.com/language/translate/v2?q=';
  String url = 'https://6a08e763.ngrok.io/conversations/default/respond';
  //String data = '{"query" : "i need a toothpaste"}';
  //url = url + _textAPI + '&target=vi&key=AIzaSyBHopk063OgUHtvupB5CvHRmSmtvwHKS8U';
  var client = http.Client();
  http.Response response = await client.post(
      Uri.encodeFull(url),
      body: """
        {
          "query" : "$_textAPI"
        }
      """,
      headers: {
        "Accept": "application/json"
      }
  );
  if(response.statusCode == 200) {
    var data = json.decode(response.body);
    //String rest = data.values.toString();
    //String rest = data[0]['text'];
    List<String> talk = new List();
    for (var i in data)
      talk.add(i['text']);
    //rest = rest.substring(33, rest.length - 32);
    print(talk);
    return talk;
  } else {
    throw Exception('Fail to translate');
  }
}

Future<void> sendImageLabel(String labels) async {
  List<String> response = new List();
  response = await getData(labels);
  for(var i in response) {
    ChatMessage botMessage = new ChatMessage(
      name: "Bot",
      text: i,
    );
    _messages.insert(0, botMessage);
  }
}

final TextEditingController _textController = new TextEditingController();
final List<ChatMessage> _messages = <ChatMessage> [];

class ChatScreenState extends State<ChatScreen> {
  void _handleSubmitted(String text) async {
    _textController.clear();
    //Create my message and add it to the List of message
    if(text != "") {
      ChatMessage chatMessage = new ChatMessage(
        name: "Me",
        text: text,
      );
      setState(() {
        _messages.insert(0, chatMessage);
      });

      //Create the response message and add it to the List of message
      List<String> response = new List();
      response = await getData(text);
      for(var i in response) {
        ChatMessage botMessage = new ChatMessage(
          name: "Bot",
          text: i,
        );
        setState(() {
          _messages.insert(0, botMessage);
        });
      }
    }
  }

  Widget _textComposerWidget(){
    return new IconTheme(
      data: new IconThemeData(color: Colors.deepOrange),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  decoration: new InputDecoration.collapsed(hintText: "Send a message"),
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                ),
              ),
              new IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 35.0,
                onPressed: (){
                  imageFile = null;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TakePicture()),
                  );
                },
              ),
              FloatingActionButton(
                child: Icon(Icons.mic),
                mini: true,
                backgroundColor: Colors.grey,
                onPressed: recordPressed,
              ),
              new Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text),
                  )
              )
            ],
          )
      ),
    );
  }


  //------------------------------VOICE INPUT-------------------------------------
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";
  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }
  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
            (bool result) => setState(() => _isAvailable = result)
    );
    _speechRecognition.setRecognitionStartedHandler(
            () => setState(() => _isListening = true)
    );
    _speechRecognition.setRecognitionResultHandler(
            (String speech) => setState(() => textCollect(speech))
    );
    _speechRecognition.setRecognitionCompleteHandler(
            () => setState(() => _isListening = false)
    );
    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

  void recordPressed() {
    if(_isAvailable && !_isListening)
      _speechRecognition
          .listen(locale: "en_US")
          .then((result) => print('$result'));
  }

  void textCollect(String text) {
    if(_isAvailable && !_isListening)
      _handleSubmitted(text);
  }

  @override
  Widget build(BuildContext context){
    return new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_,int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height: 1.0,),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _textComposerWidget(),
        )
      ],
    );
  }
}