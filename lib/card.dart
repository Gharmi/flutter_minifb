import 'package:flutter/material.dart';

class CardLayout1 extends StatefulWidget {
  final String photourl, displayName, title, location, imageURL;
  final String date;

  const CardLayout1(
      {Key key,
      this.photourl,
      this.displayName,
      this.title,
      this.location,
      this.date,
      this.imageURL})
      : super(key: key);

  @override
  _CardLayout1State createState() => _CardLayout1State();
}

class _CardLayout1State extends State<CardLayout1> {
  int starCount = 5;
  bool starCheck = false;

  String dayCalculate(String datetime) {
    DateTime d1 = DateTime.now();
    DateTime d2 = DateTime.parse(datetime);
   
    
     var diff = d1.difference(d2);  //d2-d1
     return ((diff.inDays).toString());
  }

  String formatter(String datetime){
    var days = int.parse(dayCalculate(datetime));

    switch(days)
    {
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
      return datetime;
      break;
    
    
  
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      color: Colors.black26,
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
                      child: ClipOval(child: Image.network(widget.photourl)),
                      backgroundColor: Colors.transparent,
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(5, 6, 2, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.displayName.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formatter(widget.date.toString().toUpperCase()),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 5),
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    widget.location,
                    style: TextStyle(
                      color: Colors.blue[100],
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: widget.imageURL != null
                        ? Image.network(widget.imageURL)
                        : SizedBox(
                            height: 20,
                          ))),
            Divider(thickness: 7, height: 10),
            Container(
              //padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(24, 5, 0, 0),
                          child: Text(starCount.toString() + ' stars')),
                      Container(
                        padding: EdgeInsets.fromLTRB(230, 5, 0, 0),
                        child: Text('5' + ' comments'),
                      ),
                    ],
                  ),
                  //Divider(thickness: 10.0),
                  Row(
                    //crossAxisAlignment: ,
                    children: <Widget>[
                      FlatButton(
                          child: Icon(
                            Icons.star,
                            color: starCheck ? Colors.blue : Colors.white,
                          ),
                          onPressed: () => setState(() {
                                if (starCheck == true) {
                                  starCheck = false;
                                  starCount--;
                                } else {
                                  starCheck = true;
                                  starCount++;
                                }

                                //starCheck?starCount-1:starCount+1;
                              })),
                      Text('Star'),
                      FlatButton(
                          child: Icon(
                            Icons.mode_comment,
                            color: starCheck ? Colors.blue : Colors.white,
                          ),
                          onPressed: () => setState(() {
                                //function()
                              })),
                      Text('Comment')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
