//import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_handler/card.dart';
import 'package:firebase_handler/models/StoreStatus.dart';

import 'package:firebase_handler/other.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';
//import 'dart:math' show Random;

import 'other.dart';


class FirstPage extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  
  FirstPage({Key key, @required this.googleSignIn});

  @override
  _FirstPageState createState() => _FirstPageState(
      googleSignIn: googleSignIn); //_FirstPageState(googleSignIn: googleSignIn)
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {

  //we can also access googleSign by constructor and by widgets too... as below
  final GoogleSignIn googleSignIn;


  _FirstPageState({this.googleSignIn});

  File _image;
  String _basename;
  bool _enable = false;

  final Firestore _firestore = Firestore.instance;

  TextEditingController taskTitleInputController = TextEditingController();
  TextEditingController locationController = new TextEditingController();
  ScrollController scrollController = ScrollController();

  bool postDisable = false;

  //Animation fabButtonanim;
  //AnimationController controller;

  @override
  void initState() {
    super.initState();
    //controller =     AnimationController(duration: Duration(seconds: 2), vsync: this);
    //   //fabButtonanim = Tween(begin: 1.0, end: -0.0008).animate(CurvedAnimation(
    //       curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
    //       parent: controller));
  }

  Future<void> getImage() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    var _futureImage = ImagePicker.pickImage(source: ImageSource.gallery);
    File image = await _futureImage;
    print("FILE SIZE BEFORE: " + image.lengthSync().toString());
    String basename = (image.path).split("/")?.last;
    print(image.path);

    var dir = await getApplicationDocumentsDirectory();
    print(dir.path);

    File compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.path,
      '${dir.path}/$randomString.jpg',
      quality: 50,
    );
    _image = compressedImage;
    print(randomString(4));

    print("FILE SIZE After : " + _image.lengthSync().toString());

    setState(() {
      print(basename);

      _basename = basename;
      _enable = true;
    });
  }

  Future<void> storeFirebase() async {


    FocusScope.of(context).requestFocus(new FocusNode());
    check().then((internet) async {
      if (!internet) {
        void _showAlert(BuildContext context, String title, String msg) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(title),
                    content: Text(msg),
                  ));
        }

        _showAlert(context, "Connection", "No internet Access");
      } else {
        if (taskTitleInputController.text.length < 1 &&
            locationController.text.length < 1 &&
            _image == null) {
          print(check);
          Scaffold.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('Please fill at least one field'),
          ));
        } else {
          if (_image != null) {
            StorageReference storageReference =
                FirebaseStorage.instance.ref().child('newsfeeds/$_basename');
            StorageUploadTask uploadTask = storageReference.putFile(_image);

            if (uploadTask.isInProgress) {
              setState(() {
                postDisable = true;
              });
              print("Uploading....");
            } else if (uploadTask.isPaused) {
              setState(() {
                postDisable = false;
              });
              print("Something went wrong!!");
            }

            final _uploadUrl =
                await (await uploadTask.onComplete).ref.getDownloadURL();

            print('Uploaded $_uploadUrl');

            StoreStatus st = StoreStatus(
                taskTitleInputController.text,
                locationController.text,
                DateTime.now().toIso8601String().toString(),
                0,
                _uploadUrl,
                [],
                googleSignIn.currentUser.displayName,
                googleSignIn.currentUser.photoUrl,
                widget.googleSignIn.currentUser.email);

            await _firestore
                .collection('events')
                .document()
                .setData(st.toMap())
                .whenComplete(() {
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 3),
                content: Text('Status Updated with image'),
              ));
              taskTitleInputController.clear();
              locationController.clear();
              setState(() {
                postDisable = false;
                _enable = false;
                _basename = null;
                _image = null;
                //_uploadUrl = '';
              });
            });

          } else {
            print('events data');

            StoreStatus st = StoreStatus(
                taskTitleInputController.text,
                locationController.text,
                DateTime.now().toIso8601String().toString(),
                0,
                null,
                [],
                googleSignIn.currentUser.displayName,
                googleSignIn.currentUser.photoUrl,
                widget.googleSignIn.currentUser.email);
            await _firestore
                .collection('events')
                .document()
                .setData(st.toMap());

            setState(() {
              postDisable = false;
              _enable = false;
              _basename = null;
              _image = null;
            });
            print('event data obtained');
            //log('Without images');
            Scaffold.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 2),
              content: Text('Status without images'),
            ));
            taskTitleInputController.clear();
            locationController.clear();
          }
        }
      }
    });

    //    else {

    // showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           title: Text("Connection"),
    //           content: Text('No internet Access'),
    //         ));

    //   }

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(

        //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(children: <Widget>[
      Container(
        height: devHeight / 10,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: TextField(
          autofocus: false,
          //scrollPadding: EdgeInsets.all(5.0),
          maxLines: 2,
          decoration: InputDecoration(
            labelText: 'What\'s on your mind ?',
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            //helperText: 'Mention in short',
          ),
          controller: taskTitleInputController,
          style: TextStyle(
            height: 2.0,
          ),
        ),
      ),
      Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: TextField(
          autofocus: false,
          scrollPadding: EdgeInsets.all(10),
          //onChanged: ((value) => (print(value))),
          decoration: InputDecoration(
            hintText: "Enter the location",
          ),
          controller: locationController,
          style: TextStyle(
            height: 2.0,
          ),
        ),
      ),
      Row(children: <Widget>[
        _enable
            ? Expanded(
                child: FlatButton(
                    child: Container(
                        child: Row(
                      children: <Widget>[
                        Image.file(
                          _image,
                          cacheHeight: 30,
                          cacheWidth: 35,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Image Selected"),
                        // SizedBox(width: 10.0,),
                        // Icon(Icons.photo),
                      ],
                    )),
                    onPressed: getImage))
            : FlatButton(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                    child: Row(
                  children: <Widget>[
                    Text("Upload Photo"),
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(Icons.photo),
                  ],
                )),
                onPressed: getImage),
        Container(
            padding: EdgeInsets.fromLTRB(100, 3, 0, 0),
            child: FlatButton(
              //disabledColor: Colors.grey,
              //disabledTextColor: Colors.black,
              child: postDisable
                  ? CircularProgressIndicator()
                  : Text(
                      "POST",
                    ),
              onPressed: postDisable ? null : storeFirebase,
            ))
      ]),
      Container(
        height: double.maxFinite,
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('events')
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
                       doc:doc,
                      currentmail: widget.googleSignIn.currentUser.email,
                    ))
                .toList();

                            


            return ListView(
              controller: scrollController,
              //reverse: true,
              children: <Widget>[
                ...events,
              ],
            );
          },
        ),
      ),
    ]));
  }
}
