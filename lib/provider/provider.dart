import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderProfile extends ChangeNotifier {
  String userId = "";
  bool isLoggedIn = false;
var a = "";
  TextEditingController nameController = TextEditingController();
  void isLogged() {
    isLoggedIn = true;
    notifyListeners();
  }

  checkUser() {
    String id = FirebaseAuth.instance.currentUser!.uid;
    return id;
  }

   nameUser(cavab){
      a = cavab  ;
  notifyListeners();
  }
}
