import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_handler/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'card.dart';
import 'package:firebase_handler/models/user.dart';
//import 'home.dart';

class SecondPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  SecondPage({Key key, @required this.googleSignIn});
  @override
  _SecondPageState createState() =>
      _SecondPageState(googleSignIn: googleSignIn);
}

class _SecondPageState extends State<SecondPage> with TickerProviderStateMixin {
  Firestore _firestore = Firestore.instance;
  AnimationController _animationController, controller;

  final GoogleSignIn googleSignIn;
  _SecondPageState({this.googleSignIn});
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _animationController = new AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    // fabButtonanim = Tween(begin: 1.0, end: -0.0008).animate(CurvedAnimation(
    //     curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
    //     parent: controller));
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('events')
            .where('userName', isEqualTo: googleSignIn.currentUser.displayName)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          List<DocumentSnapshot> docs = snapshot.data.documents;

          List<Widget> events = docs
              .map((doc) => CardLayout1(
                    doc: doc,
                    currentmail: widget.googleSignIn.currentUser.email,
                  ))
              .toList();
          return Scrollbar(
              child: ListView(
            //reverse: true,
            children: <Widget>[
              ...events,
            ],
          ));
        },
      ),
    );
  }
}
