import 'package:shared_preferences/shared_preferences.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';
import 'api_service.dart';
import 'iservice.dart';
import 'package:logger/logger.dart';

class UserService implements Iservice<User> {
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

  static Future<bool> login(dynamic data, UserController u) async {
    var user = {"username": "bdht2207a1", "password": "123456"};
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await DioService().post("/auth/login", data: user).then((value) async {
        // cast to LoginResponse
        Logger().i("Login Success $value.data");
        User data = User.fromJson(value.data);
        await prefs.setString('access-token', data.authResponse!.token);
        await prefs.setString('refresh-token', data.authResponse!.refreshToken);
        Logger().i("Login Success $data");
        u.setUser(data);
        return true;
      });
    } catch (e) {
      Logger().e('er:-----------$e');
    }
    return false;
  }

  // logout
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access-token');
    await prefs.remove('refresh-token');
  }
}
