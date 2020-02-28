import 'package:firebase_handler/main.dart';
import 'package:firebase_handler/models/user.dart';
import 'package:firebase_handler/theme_changer.dart';
import 'package:firebase_handler/uploadedPost.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'floatingButton.dart';
import 'secondPage.dart';
import 'main.dart';

class Home extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  //final UserData userData;

  Home({Key key, @required this.googleSignIn});

  @override
  HomePage createState() => HomePage(googleSignIn: googleSignIn);
}

class HomePage extends State<Home> {
  GoogleSignIn googleSignIn;
  //final UserData userData;

  HomePage( {this.googleSignIn});

  int pos = 0;

  Widget getWidget(BuildContext context, int pos) {
    switch (pos) {
      case 0:
         FocusScope.of(context).requestFocus(new FocusNode());
        return FirstPage(googleSignIn: googleSignIn);
        break;

      case 1:
         FocusScope.of(context).requestFocus(new FocusNode());
        return SecondPage(googleSignIn: googleSignIn);
        break;

      default:
        FocusScope.of(context).requestFocus(new FocusNode());
        return FirstPage(googleSignIn: googleSignIn);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Scaffold(
      appBar: AppBar(
        title: pos==0?Text('News Feed'):Text('My Posts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text("Do you want to logout?"),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          googleSignIn.signOut();
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        })
                  ],
                ),
              );
            },
          )
        ],
      ),
      drawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(googleSignIn.currentUser.displayName),
                accountEmail: Text(googleSignIn.currentUser.email),
                currentAccountPicture: new Container(
                    height: 80.0,
                    width: 80.0,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage(googleSignIn.currentUser.photoUrl),
                      backgroundColor: Colors.transparent,
                    )),
                //backgroundImage: Image.network(googleSignIn.currentUser.photoUrl),
                // decoration
              ),
              ListTile(
                leading: Icon(Icons.image_aspect_ratio),
                title: Text(
                  'News Feed',
                  style: pos == 0 ? TextStyle(color: Colors.blue) : null,
                ),
                onTap: () {
                  setState(() => pos = 0);
                  Navigator.pop(context);
                  // This line code will close drawer programatically....
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text(
                  'Uploaded Posts',
                  style: pos == 1 ? TextStyle(color: Colors.blue) : null,
                ),
                onTap: () {
                  setState(() => pos = 1);
                  Navigator.pop(context);
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
                onTap: () {
                  showDialog<String>(
                    context: context,
                    child: AlertDialog(
                      content: Text("Do you want to logout?"),
                      actions: <Widget>[
                        FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              googleSignIn.signOut();
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            })
                      ],
                    ),
                  );
                },
              ),
              Divider(
                height: 2.0,
              ),
              ListTile(
                  title: Text('Change theme'),
                  trailing: Switch(
                    value: false,
                    onChanged: (changedTheme) {
                      setState(() {
                        mode==0?mode=1:mode=0;
                        changedTheme = !changedTheme;
                      });
                    },
                  )),
            ],
          )),
      //floatingActionButton: FloatHandler(),
      body: getWidget(context, pos),
    ));
  }
}
