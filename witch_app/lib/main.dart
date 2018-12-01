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
      home: LandingPage(title: 'witch app'),
    );
  }
}

class LandingPage extends StatelessWidget {
  LandingPage({Key key, this.title}) : super(key: key);
  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('assets/witch-app-white.png', fit: BoxFit.cover),
      ),
      backgroundColor: Theme.CustomColors.lightPink[500],

      body: GridList.GridListDemo()

//      body: Center(
//          child: Text(
//            "hello this is app",
//            style: TextStyle(
//                fontSize: 30.0,
//                color: Theme.CustomColors.darkPink[500]
//            ),
//          )
//      ),
    );
  }
}