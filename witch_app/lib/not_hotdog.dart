import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_theme.dart' as Theme;
import 'prediction.dart';

class NotHotdog extends StatefulWidget {
  @override
  _NotHotdogState createState() => new _NotHotdogState();
}

class _NotHotdogState extends State<NotHotdog> {
  File _image;
  List _recognitions;
//  bool _isHotdog;

  Future getImage(ImageLocation imageLocation) async {
    var image;
    switch (imageLocation) {
      case ImageLocation.camera:
        image = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case ImageLocation.gallery:
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

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
    print(recognitions);
    setState(() {
      _recognitions = recognitions;
    });
//     await Tflite.close();
  }

  Future<bool> determineIfHotdog() async {
    if (_recognitions == null) return null;
    var isHotdog = false;
    var mappedRec = _recognitions.map((res) {
      return Recognition(res["label"], res["confidence"]);
    });

    if (mappedRec.isNotEmpty) {
      mappedRec.forEach((item) {
        print(item.label + " - " + item.confidence.toString());
        if (item.label == "hotdog") {
          if (item.confidence > 0.25) {
            isHotdog = true;
          }
        }
      });
    }

    return isHotdog;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Not Hotdog', style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.CustomColors.lightPink[500],
        body: Stack(
          children: <Widget>[
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),

            FutureBuilder(
                future: determineIfHotdog(),
                builder: (
                    BuildContext context,
                    AsyncSnapshot<bool> isHotdog,
                    ) {
                  if (isHotdog.data != null) {
                    print(">>> isHotdog?");
                    print(isHotdog.data);
                    return Prediction(isHotdog.data);
                  } else {
                    return Container();
                  }
                }),

//
//            Container(
//              child: _recognitions != null ?
//                  Prediction(determineIfHotdog()) : null
//            ),


          ],
        ),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              onPressed: () { getImage(ImageLocation.camera); },
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            new Container(
              width: 10.0,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () { getImage(ImageLocation.gallery); },
              tooltip: 'Pick Image',
              child: Icon(Icons.insert_photo),
            ),
          ],
        )
      );
  }
}

enum ImageLocation {
  camera,
  gallery
}

class Recognition {
  String label;
  double confidence;

  Recognition(String label, double confidence) {
    this.label = label;
    this.confidence = confidence;
  }
}