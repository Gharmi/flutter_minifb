import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardLayout1 extends StatefulWidget {
  // final String photourl,
  //     displayName,
  //     title,
  //     location,
  //     imageURL,
  //     id,
  //     email,
  //     date;

  // final int likes;
  // final List<String> liker;
  final String currentmail;
  final doc;

  const CardLayout1({Key key, this.doc, this.currentmail}) : super(key: key);

  @override
  _CardLayout1State createState() =>
      _CardLayout1State(doc: doc, currentmail: currentmail);
}

class _CardLayout1State extends State<CardLayout1>
    with TickerProviderStateMixin {
  Firestore _firestore = Firestore.instance;
  int commentCount = 0;
  bool commentCheck = false;

  // final String photourl,
  //     displayName,
  //     title,
  //     location,
  //     imageURL,
  //     id,
  //     email,
  //     currentmail;

  // final String date;
  // final int likes;
  // final List liker;
  bool starCheck;
  int starCount;

  final currentmail;
  final doc;

  _CardLayout1State({
    this.doc,
    this.currentmail,
  });

  //AnimationController _breathingController;
  // var _breathe = 0.0;
  AnimationController _angleController;
  var _angle = 0.0;

  bool starCheckFunc(List liker, String currmail) {
    print(currmail);
    print('inside');
    bool starCheck1 = false;
    for (String like in liker) {
      if (like == currmail) {
        print('trueeee');
        starCheck1 = true;
        break;
      }
    }
    return starCheck1;
  }

  @override
  void initState() {
   

    // starCount = widget.likes;
    print(widget.currentmail);
    print(starCheck);
    print('isitnull');

    super.initState();

    // _breathingController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 1000));
    // _breathingController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     _breathingController.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     _breathingController.forward();
    //   }
    // });
    // _breathingController.addListener(() {
    //   setState(() {
    //     _breathe = _breathingController.value;
    //   });
    // });
    //_breathingController.forward();

    _angleController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _angleController.addListener(() {
      setState(() {
        _angle = _angleController.value * 360 / 360 * 2 * pi;
      });
    });
  }

  @override
  void dispose() {
    // _breathingController.dispose();
    _angleController.dispose();
    super.dispose();
  }

  String minCalculate(String datetime) {
    DateTime d1 = DateTime.now();
    DateTime d2 = DateTime.parse(datetime);

    var diff = d1.difference(d2); //d2-d1
    return ((diff.inMinutes).toString());
  }

  String minFormatter(String datetime) {
    var minutes = int.parse(minCalculate(datetime));

    switch (minutes) {
      case 0:
        return "Just Now";
        break;

      case 1:
        return "1 min ago";
        break;

      case 2:
        return "2 mins ago";
        break;

      default:
        return hourFormatter(datetime);
        break;
    }
  }

  String hourCalculate(String datetime) {
    DateTime d1 = DateTime.now();
    DateTime d2 = DateTime.parse(datetime);

    var diff = d1.difference(d2); //d2-d1
    return ((diff.inHours).toString());
  }

  String hourFormatter(String datetime) {
    var hours = int.parse(hourCalculate(datetime));

    switch (hours) {
      case 0:
        return "Few minutes earlier";
        break;

      case 1:
        return "1 hour ago";
        break;

      case 2:
        return "2 hours ago";
        break;

      default:
        return dayFormatter(datetime);
        break;
    }
  }

  String dayCalculate(String datetime) {
    DateTime d1 = DateTime.now();
    DateTime d2 = DateTime.parse(datetime);

    var diff = d1.difference(d2); //d2-d1
    return ((diff.inDays).toString());
  }

  String dayFormatter(String datetime) {
    var days = int.parse(dayCalculate(datetime));

    switch (days) {
      case 0:
        return "Today";
        break;

      case 1:
        return "Yesterday";
        break;

      case 2:
        return "2 days ago";
        break;

      default:
        return getDateOnly(datetime);
        break;
    }
  }

  String getDateOnly(String date) {
    DateTime d1 = DateTime.parse(date);
    return DateFormat.yMMMd().format(d1);
  }

  @override
  Widget build(BuildContext context) {
    // final size = 21.0 - 10.0 * _breathe;
    starCheck = starCheckFunc(List.from(widget.doc.data['liker']), widget.currentmail);
    starCount = widget.doc.data['likes'];
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    height: 60.0,
                    width: 60.0,
                    padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                    child: new CircleAvatar(
                      radius: 30.0,
                      child: ClipOval(
                          child: Image.network(widget.doc.data['prflurl'])),
                      backgroundColor: Colors.transparent,
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(5, 6, 2, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              widget.doc.data['userName'].toUpperCase(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' updated a status . ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          minFormatter(
                              widget.doc.data['date'].toString().toUpperCase()),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 8.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
              child: Text(
                widget.doc.data['title'],
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Row(
                children: <Widget>[
                  widget.doc.data['location'] == ''
                      ? SizedBox(height: 5)
                      : Icon(Icons.location_on, color: Colors.black87),
                  Text(
                    widget.doc.data['location'],
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                      backgroundColor: Colors.blue[2],
                    ),
                  ),
                ],
              ),
            ),
            Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: widget.doc.data['imageURL'] != null
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading2.gif",
                            image: doc.data['imageURL'])
                        : null)),
            Divider(thickness: 7, height: 10),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: starCount == 0
                              ? Text(
                                  'Be the first to twinkle this post',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 6,
                                      color: Colors.black),
                                )
                              : null),
                      Container(
                          padding: EdgeInsets.fromLTRB(24, 5, 0, 0),
                          child: starCount == 0
                              ? null
                              : starCount == 1
                                  ? Text(
                                      starCount.toString() + ' star',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : Text(
                                      starCount.toString() + ' stars',
                                      style: TextStyle(color: Colors.black),
                                    )),
                      Container(
                        padding: EdgeInsets.fromLTRB(230, 5, 0, 0),
                        child: commentCount == 0
                            ? null
                            : Text(
                                commentCount.toString() + ' comments',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Transform.rotate(
                          angle: _angle,
                          child: FlatButton(
                              onPressed: () => setState(() {
                                    starCheck=!starCheck;
                                    print('inside click check');

                                    print(widget.doc.documentID);

                                    if (!starCheck) {
                                      print('dislike!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                      print(widget.currentmail);
                                     
                                      print(starCheck);
                                      starCount = starCount - 1;
                                      _firestore
                                          .collection('events')
                                          .document(widget.doc.documentID)
                                          .updateData({'likes': starCount});   

                                      _firestore
                                          .collection('events')
                                          .document(widget.doc.documentID)
                                          .updateData({
                                        'liker': FieldValue.arrayRemove(
                                            [widget.currentmail])
                                      });
                                      //starCheckFunc(liker);
                                    } else {
                                      print('liked!!!!!!!!!!!!!!!!!!!!!!!!!');

                               

                                      starCount = starCount + 1;
                                      _firestore
                                          .collection('events')
                                          .document(widget.doc.documentID)
                                          .updateData({
                                        'likes': FieldValue.increment(1)
                                      });
                                      _firestore
                                          .collection('events')
                                          .document(widget.doc.documentID)
                                          .updateData({
                                        'liker': FieldValue.arrayUnion(
                                            [widget.currentmail])
                                      });
                                      //starCheckFunc(liker);
                                    }
                                    if (_angleController.status ==
                                        AnimationStatus.completed) {
                                      _angleController.reverse();
                                    } else if (_angleController.status ==
                                        AnimationStatus.dismissed) {
                                      _angleController.forward();
                                    }
                                  }),
                              child: Container(
                                // height : size,
                                // width: size,
                                // decoration: BoxDecoration(

                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(21)),
                                //     border: Border.all(
                                //         color: Colors.white, width: 2)),
                                child: Icon(
                                  Icons.star,
                                  color:
                                      starCheck ? Colors.blue : Colors.black38,
                                ),
                              ))),
                      Text('Star'),
                      FlatButton(
                          child: Icon(
                            Icons.mode_comment,
                            color: commentCount == 0
                                ? Colors.black38
                                : Colors.blue,
                          ),
                          onPressed: () => setState(() {
                                if (commentCheck == true) {
                                  commentCheck = false;
                                  commentCount--;
                                } else {
                                  commentCheck = true;
                                  commentCount++;
                                }
                              })),
                      Text(
                        'Comment',
                        style: TextStyle(
                            color:
                                commentCount == 0 ? Colors.black : Colors.blue),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
