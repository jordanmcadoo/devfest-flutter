import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';

import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'camera_selection.dart' as CameraSelection;

import 'custom_theme.dart' as Theme;

//class NotHotdog extends StatelessWidget {
//  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//  }
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('Not Hotdog'),
//        ),
//        backgroundColor: Theme.CustomColors.lightPink[500],
//        body: Center(
//          child: FloatingActionButton(onPressed: getImage)
//        )
//    );
//  }
//}

class NotHotdog extends StatefulWidget {
  @override
  _NotHotdogState createState() => new _NotHotdogState();
}

class _NotHotdogState extends State<NotHotdog> {
  File _image;
  List _recognitions;
  List<CameraDescription> _cameras;

  Future _loadCamera() async {
    try {
      var cameras = await availableCameras();
      setState(() {
        _cameras = cameras;
      });
    } on CameraException catch (e) {
      print('Error: $e.code\nError Message: $e.message');
    }
  }

  void openCameraSelection(BuildContext context) async {
    await _loadCamera();
    Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          //return HotdogApp.NotHotdog();
          return CameraSelection.HomePage(_cameras);
        }
    ));
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    recognizeImage(image);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    try {
      String res = await Tflite.loadModel(
        model: "assets/graph.tflite",
        labels: "assets/labels.txt",
      );
      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
    );
    print(">>>>");
    print(recognitions);
    setState(() {
      _recognitions = recognitions;
    });
    // await Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Not Hotdog'),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
            Center(
              child: Column(
                children: _recognitions != null
                    ? _recognitions.map((res) {
                  return Text(
                    "${res["index"]} - ${res["label"]}: ${res["confidence"].toString()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      background: Paint()..color = Colors.white,
                    ),
                  );
                }).toList()
                    : [],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { openCameraSelection(context); },
//          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }
}
