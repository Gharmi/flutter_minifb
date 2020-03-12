class StoreStatus {
  String title, location, date, imageURL, userName, prflurl, email;
  int likes;
  List liker;

  StoreStatus(
    this.title,
    this.location,
    this.date,
    this.likes,
    this.imageURL,
    this.liker,
    this.userName,
    this.prflurl,
    this.email,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['location'] = location;
    map['date'] = date;
    map['likes'] = likes;
    map['imageURL'] = imageURL;
    map['liker'] = liker;
    map['prflurl'] = prflurl;
    map['userName'] = userName;
    map['email'] = email;

    return map;
  }

  StoreStatus.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.location = map['location'];
    this.date = map['date'];
    this.likes = map['likes'];
    this.imageURL = map['imageURL'];
    this.liker = map['liker'];
    this.prflurl = map['prflurl'];
    this.email = map['email'];
  }

  String get getTitle => title;
  String get getLocation => location;
  String get getDate => date;
  int get getLikes => likes;
  String get getImageURL => imageURL;
  List get getLiker => liker;
  String get getPrflurl => prflurl;
  String get getEmail => email;
}
