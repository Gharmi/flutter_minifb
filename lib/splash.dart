import 'package:firebase_handler/signin.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MyHomePage1 extends StatefulWidget {
  MyHomePage1({Key key, @required this.title}) : super(key: key);

  final String title;
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyHomePage1> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MyHomePage(title: 'Event Handler'),
      title: new Text('Flutter Handler',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color:  const Color(0xFF9B9700),
      ),),
      image: new  Image.asset('assets/images/logo_dark.png',repeat: ImageRepeat.repeat,),
      backgroundColor: Colors.black26,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red,
      loadingText: new Text('Please wait for a while...'),
    );
  }
}