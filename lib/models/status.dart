import 'package:cloud_firestore/cloud_firestore.dart';

class StatusFireBase {
  String photourl,
      displayName,
      title,
      location,
      imageURL,
      id,
      email,
      date,
      currentmail;

  List liker;
   int likes;

  StatusFireBase(
    this.id,
    this.photourl,
    this.displayName,
    this.title,
    this.location,
    this.likes,
    this.liker,
    this.date,
    this.imageURL,
    this.email,
    this.currentmail,
  );

  Map<String, dynamic> toMap(){
    var map=Map<String,dynamic>();
    map['id']=id;
    map['photourl']=photourl;
    map['displayName']=displayName;
    map['title']=title;
    map['location']=location;
    map['likes']=likes;
    map['liker']=liker;
    map['date']=date;
    map['imageURL']=imageURL;
    map['email']=email;
    map['currentmail']=currentmail;
    return map;
  }



    StatusFireBase
    .fromMap(Map<String,dynamic> map){
    this.id= map['id'];
    this.photourl = map['photourl'];
    this.displayName = map['displayName'];
    this.title = map['title'];
    this.location = map['location'];
    this.likes=map['likes'];
    this.liker=map['liker'];
    this.date=map['liker'];
    this.date=map['date'];
    this.imageURL=map['imageURL'];
    this.email=map['email'];
  }

  String get  getId => id;
  String get getPhotourl => photourl;
  String get getDisplayName => displayName;
  String get getTitle => title;
  String get getLocation => location;
  int get getLikes => likes;
  List get getLiker=>liker;
  String get getDate => date;
  String get getImageURL => imageURL;
  String get getEmail => email;


}
