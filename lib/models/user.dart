class UserData {
  String username, photourl, email;
  
  bool _isLoggedin;
  
  UserData(this.username, this.photourl, this.email, this._isLoggedin);
  String getname() {
    return username;
  }

  String getphotourl() {
    return photourl;
  }

  String getemail() {
    return email;
  }
  bool getLog(){
    return _isLoggedin;
  }
}
