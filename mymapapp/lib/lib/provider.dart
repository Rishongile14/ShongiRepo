
import 'package:flutter/material.dart';
import 'package:mymapapp/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User(email: '', id: -1);

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setEmail(String email) {
    _user.email = email;
    notifyListeners();
  }

  void setId(int id){
    _user.id = id;
    notifyListeners();
  }

  void clearUser(){
    _user.id = -1;
    _user.email = ' ';
    notifyListeners();
  }
}