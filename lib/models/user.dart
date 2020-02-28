import 'package:google_sign_in/google_sign_in.dart';

class UserData {

   GoogleSignInAccount account;
  
   UserData({this.account});
   



   String getname() {
    return account.displayName;
  }

   String getphotourl() {
    return account.photoUrl;
  }

   String getemail() {
    return account.email;
  }
   String getdisplayName(){
    return account.displayName;
  }
}
