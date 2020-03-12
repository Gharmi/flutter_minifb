import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';

import 'splash.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      //Add Route to the main Page.
      routes: {'/splash': (context) => MyHomePage1(title: "Flutter handler")},
      title: 'Fancy OnBoarding Demo',
      //theme: ThemeData(primarySwatch: Colors.black26, fontFamily: 'Nunito'),
    theme: ThemeData.dark(),
      home: BoardPage(title: 'Boarding screen'),
    );
  }
}

class BoardPage extends StatefulWidget {
  BoardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<BoardPage> {
  static Shader linearGradient = LinearGradient(colors: <Color>[
    Colors.white,
    Colors.deepPurple,
    Colors.black,
  ]).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 30.0));
  //Create a list of PageModel to be set on the onBoarding Screens.
  final pageList = [
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/svg_file/note_add.svg',
        title: Text('Share',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('Add Events and Informations',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/svg_file/note_add.svg'),
    PageModel(
        color: Colors.deepOrangeAccent,
        heroAssetPath: 'assets/svg_file/view.svg',
        title: Text('View',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('View all the events shared!!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/svg_file/view.svg'),
    PageModel(
      color: const Color(0xFF9B900C),
      heroAssetPath: 'assets/svg_file/react.svg',
      title: Text('React',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('You can react upon the events shared',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/svg_file/react.svg',
    ),
    // SVG Pages Example
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/svg_file/media.svg',
        title: Text('Media Sharing',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('Share Media Files',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/svg_file/media.svg'),
    PageModel(
      color: const Color(0xFF9B9BBC),
      heroAssetPath: 'assets/svg_file/done_all.svg',
      title: Text('You\'re done....',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              // color: Colors.white,
              fontSize: 34.0,
              foreground: Paint()..shader = linearGradient)),
      body: Text(
        '',
        textAlign: TextAlign.center,
        style: TextStyle(
            // color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = linearGradient),
      ),
      iconAssetPath: 'assets/svg_file/done_all.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Pass pageList and the mainPage route.
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/splash'),
        onSkipButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/splash'),
      ),
    );
  }
}
