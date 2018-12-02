import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'custom_theme.dart' as Theme;

class NotHotdog extends StatelessWidget {
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Not Hotdog'),
        ),
        backgroundColor: Theme.CustomColors.lightPink[500],
        body: Center(
          child: FloatingActionButton(onPressed: getImage)
        )
    );
  }
}