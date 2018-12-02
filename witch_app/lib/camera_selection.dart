import 'dart:io';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';

import 'camera.dart';
import 'prediction.dart';
import 'share.dart';
import 'evaluating.dart';
//import 'bndbox.dart';

class Recognition {
  String label;
  int confidence;

  Recognition(String label, int confidence) {
    this.label = label;
    this.confidence = confidence;
  }
}

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showButton = true;
  String imageFile;
  Map<String, dynamic> image;
  bool showBox = false;

  @override
  void initState() {
    super.initState();
  }
  
  Future<bool> _recognizeImage(Size screen) async {
    if (imageFile == null) return null;
    var recognitions = await Tflite.runModelOnImage(
      path: imageFile,
      numResults: 6,
      threshold: 0.05,
    );
    print(">>>>>");
    print(recognitions);

    var mappedRec = new List();
    if (recognitions != null) {
      print("mapping recs");
      recognitions.map((res) {
        mappedRec.add(Recognition(res["label"], res["confidence"]));
      });

      var isHotdog = mappedRec.where((e) => e.label == "hotdog").first;
      if (isHotdog != null) {
        if (isHotdog.confidence > 0.25) {
          print("returning true");
          return true;
        }
      }
    }
    print("returning false");
    return false;
  }

  void getImage(string) {
    imageCache.clear();
    new FileImage(File(string))
        .resolve(new ImageConfiguration())
        .addListener((ImageInfo info, bool _) {
      setState(() {
        image = {
          "image": info.image,
          "height": info.image.height.toDouble(),
          "width": info.image.width.toDouble()
        };
        imageFile = string;
      });
    });
  }

  void onClear() {
    setState(() {
      File(imageFile).delete();
      imageFile = null;
      image = null;
      showButton = true;
      showBox = false;
    });
  }

  void hideButton(String str) {
    setState(() {
      showButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Camera(widget.cameras, showButton, hideButton, getImage),
          image != null && image["image"] != null
              ? GestureDetector(
            onTap: () {
              setState(() {
                showBox = !showBox;
              });
            },
            child: Container(
              width: size.width,
              height: size.height,
              child: RawImage(
                image: image["image"],
                fit: BoxFit.cover,
              ),
            ),
          )
              : Container(),
          FutureBuilder(
              future: _recognizeImage(size),
              builder: (
                  BuildContext context,
                  AsyncSnapshot<bool> result,
                  ) {
                    if (result.data != null) {
                      var isHotdog = result.data;
                      return Stack(
                        children: <Widget>[
                          //BndBox(showBox ? rects.data : []),
                          Prediction(isHotdog),
                          ShareResult(onClear, isHotdog),
                        ],
                      );
                    } else if (imageFile != null)
                      return Evaluating();
                    else
                      return Container();
                  }
            ),
        ],
      ),
    );
  }
}
