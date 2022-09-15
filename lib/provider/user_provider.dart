import 'package:flutter/cupertino.dart';

import '../firbase_services/auth.dart';
import '../models/user.dart';




class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;
  
  refreshUser() async {
    UserData userData = await AuthMethods().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
 }