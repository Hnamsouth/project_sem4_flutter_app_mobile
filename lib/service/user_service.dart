import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_response.dart';
import '../model/user_model.dart';
import 'api_service.dart';
import 'iservice.dart';
import 'package:logger/logger.dart';

class UserService implements Iservice<User> {
  // Future<User> getUserTest() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   return User(
  //     id: 1,
  //     username: 'user',
  //     password: 'password',
  //     created_at: DateTime.now(),
  //     status: true,
  //   );
  // }

  @override
  Future<User> create(User s) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll() async {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<User> getOne(int id) async {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<List<User>> search(String query) async {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<User> update(User s) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  static Future<User?> login(dynamic data) async {
    var user = {"username": "hiennd", "password": "hiennd"};
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await DioService().post("/auth/login", data: data).then((value) async {
        // cast to LoginResponse
        Logger().i("Login Success $value.data");
        User data = User.fromJson(value.data);
        Logger().i("Login Success $data");
        await prefs.setString('access-token', data.authResponse!.token);
        await prefs.setString('refresh-token', data.authResponse!.refreshToken);



        return data;
      });
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  // logout
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access-token');
    await prefs.remove('refresh-token');
  }





}
