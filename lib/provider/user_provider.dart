import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  Future<void> setUser(User user) async {
    _user = user;
    notifyListeners();
  }
}
