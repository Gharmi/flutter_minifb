import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FloatHandler extends StatefulWidget {
  @override
  __FloatHandlerState createState() => __FloatHandlerState();
}

class __FloatHandlerState extends State<FloatHandler> {
  TextEditingController taskTitleInputController;
  TextEditingController taskDescripInputController;

  File _image;
  String _basename = "Choose an image";
  bool _enable = true;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    String basename = (image.path).split("/")?.last;
    setState(() {
      _image = image;
      _basename = basename;
      _enable = true;
    });
  }

  Future storeImage() async {
    final FirebaseStorage storage = FirebaseStorage(
        app: Firestore.instance.app,
        storageBucket: 'gs://fir-events-7384e.appspot.com');

    StorageReference storageReference =
        storage.ref().child('visit2020/$_basename');

    StorageUploadTask uploadTask = storageReference.putFile(_image);
    if (uploadTask.isInProgress) {
      setState(() {
        _enable = false;
      });
      print("Uploading....");
    }
    if (uploadTask.isCanceled) {
      print("Something went wrong!!");
    }
    await uploadTask.onComplete;
    if (uploadTask.isComplete) {
      print("Uploaded..");
    }

    setState(() {
      _enable = true;
    });

    // Scaffold.of(context)
    //     .showSnackBar(SnackBar(content: Text('File successfully uploaded')));
    // how to context here scaffold???
    //  storageReference.getDownloadURL().then((fileURL) {
    //    setState(() {
    //      _uploadedFileURL = fileURL;
    //    });
    //  });
  }

  _showDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(children: <Widget>[
          Text('Under Construction'),
          Expanded(
            child: TextField(
              autofocus: false,
              maxLines: 8,
              onChanged: ((value) => (print(value))),
              decoration: InputDecoration(labelText: 'What\'s on your mind'),
              controller: taskTitleInputController,
              style: TextStyle(
                height: 2.0,
              ),
            ),
          ),
          // Expanded(

          //   child: TextField(
          //     autofocus: true,
          //     maxLines: 8,

          //     decoration: InputDecoration(labelText: 'Place'),
          //     controller: taskTitleInputController,
          //     style: TextStyle(
          //       height: 2.0,
          //     ),
          //   ),
          // ),
          Center(
            child: _image == null
                ? Text('No image selected.')
                : _enable
                    ? Image.file(
                        _image,
                        cacheHeight: 500,
                        cacheWidth: 350,
                      )
                    : Row(children: <Widget>[
                        CircularProgressIndicator(),
                        Text("Uploading...")
                      ]),
          ),
          RaisedButton(
            child: _image == null ? Text("Choose Photo") : Text(_basename),
            onPressed: getImage,
          ),
          RaisedButton(
            child: Text("Upload"),
            onPressed: _enable ? storeImage : null,
          ),
        ]),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Add Email'),
              onPressed: () {
                String name = "Under development";

                showSnackbar(context, name);
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _showDialog(context),
    )));
  }
}

showSnackbar(BuildContext context, String name) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(name)));
}
