//import 'package:firebase_handler/theme_changer.dart';
import 'package:firebase_handler/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';


// void main() => runApp(MyApp());

// int mode = 1;

// class MyApp extends StatelessWidget {
  
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       //initialRoute: '/home',
//       routes: <String, WidgetBuilder>{
//         //set routes for Navigation
//       },
//       theme:  mode==0?ThemeData.light():ThemeData.dark(),
         
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    
    return new WillPopScope(
      onWillPop: _onWillPop,
    child:Scaffold(
      
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: DetailBox(),
    ));
  }
}

class DetailBox extends StatefulWidget {
  @override
  _DetailBoxState createState() => _DetailBoxState();
}

class _DetailBoxState extends State<DetailBox> {
  // @override
  // void initState() {
  //   if (account != null) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => Home(googleSignIn: googleSignIn)));
  //   }
  //   super.initState();
  // }

  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount account;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _login() async {
    try {
      account =
          await googleSignIn.signIn().catchError((e) => print(e.toString()));
      final GoogleSignInAuthentication googleSignInAuthentication =
          await account.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      // final FirebaseUser user = authResult.user;

      // final FirebaseUser currentUser = await _auth.currentUser();

      //can use currentUser in googleSIgnIn
      if (account != null) {
       
        print('Successfully signed...');
        //UserData userData =UserData(account: account);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(googleSignIn: googleSignIn)));
      } else {
        Navigator.pop(context);
      }
    } catch (err) {
      void _showAlert(BuildContext context, String title, String msg) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(title),
                  content: Text(msg),
                ));
      }

      _showAlert(context, err, "Network Error or timeout");
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(

        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Center(
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          
            children: <Widget>[
            
              new CircleAvatar(
                      radius: 100.0,
                      child: ClipOval(
                          child: Image.asset('assets/images/logo.png'),),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 250),
             
            CustomButton(
          text: "Sign in with Google",
          callback: _login,
        )])),
    
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const CustomButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250.0,
        child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.google,
                  color: (Colors.red[300]),
                ),
                SizedBox(width: 10.0),
                Text(
                  text,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ],
            ),
            onPressed: () {
              callback();
              //_login();
            },
          ),
        ));
  }
}
