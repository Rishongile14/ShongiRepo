import 'package:flutter/cupertino.dart';

import 'driver.dart';

class DriverProvider with ChangeNotifier{
  Driver _driver = Driver( email: ' ', id: -1);
  Driver get driver => _driver;

   void setDriver(){
     _driver = driver;
     notifyListeners();
   }

   void setEmail(email){
     _driver.email = email;
     notifyListeners();
   }

   void setId(id){
     _driver.id = id;
     notifyListeners();
   }
   void clearUser(){
     _driver.id = -1;
     _driver.email = ' ';
     notifyListeners();
   }

}