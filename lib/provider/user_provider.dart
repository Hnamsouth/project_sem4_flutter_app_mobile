import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/user_model.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  Future<void> setUser(User user) async {
    _user = user;
    notifyListeners();
  }

  Future<void> login() async {
    String url = "http://localhost:8080/api/v1/auth/login";
    var user = await Dio().post(url, data: {
      "username": "user1",
      "password": "asd123",
    });
    Logger().i(user.data);
  }
}
