import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:hackathon/bot/chat_screen.dart';


List<String> labelTexts = new List();
List<double> rate = new List();
String text;
File imageFile;

class TakePicture extends StatefulWidget {
  @override
  TakePictureState createState() => new TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  Future getImage() async {
    labelTexts.clear();
    rate.clear();
    final _imageFile = await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600.0, maxHeight: 900.0);
    if(mounted)
      setState((){imageFile = _imageFile;});
    labeling();
  }

  Future labeling() async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    final ImageLabeler labeler = FirebaseVision.instance.cloudImageLabeler();
    final List<ImageLabel> labels = await labeler.processImage(visionImage);
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    setState(() {
      for (ImageLabel label in labels) {
        final String text = label.text;
        final double confidence = label.confidence;
        labelTexts.add(text);
        rate.add(confidence);
      }
      text = visionText.text;
      sendImageLabel(labelTexts[0]);
    });
    //Debug
    //print(labelTexts[0]);
    //print(labelTexts[1]);
    //print(labelTexts[2]);
    //print(labelTexts[3]);
    //print(labelTexts[4]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a picture"),
        backgroundColor: Colors.purple,
      ),
      body:
      Center(
        /*height: 500.0,
        width: 300.0,
        decoration: BoxDecoration(
          image: DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover),
        ),*/
        child: imageFile == null? new Text('No image',style: TextStyle(fontSize: 25.0),):new Image.file(imageFile),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo), backgroundColor: Colors.orange,
        ),
    );
  }
}

