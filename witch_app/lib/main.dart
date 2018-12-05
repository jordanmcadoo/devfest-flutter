import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'custom_theme.dart' as Theme;
import 'grid_list.dart' as GridList;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.light
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      color: Theme.CustomColors.greenBlue[500],
      theme: Theme.CustomTheme,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('assets/witch-app-white.png', fit: BoxFit.cover),
      ),
      backgroundColor: Theme.CustomColors.lightPink[500],
      body: GridList.GridListDemo()
    );
  }
}