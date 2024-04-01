import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_response.dart';
import '../model/user_model.dart';
import 'api_service.dart';
import 'iservice.dart';
import 'package:logger/logger.dart';

class UserService implements Iservice<User> {
  Future<User> getUserTest() async {
    await Future.delayed(Duration(seconds: 1));
    return User(
      id: 1,
      username: 'user',
      password: 'password',
      created_at: DateTime.now(),
      status: true,
    );
  }

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

  static Future<Object?> login(dynamic data) async {
    var user = {"username": "bdht2207a", "password": "bdht2207a"};
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await DioService().post("/auth/login", data: data).then((value) async {
        // cast to LoginResponse
        Logger().i("Login Success $value.data");
        LoginResponse data = LoginResponse.fromJson(value.data);
        Logger().i("Login Success $data");
        await prefs.setString('access-token', data.authResponse.token);
        await prefs.setString('refresh-token', data.authResponse.refreshToken);
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

// final Dio _dio = Dio();
//
//
// Future<Response> login1(String username, String password) async {
//   try {
//     Response response = await _dio.post(
//       'https://api.loginradius.com/identity/v2/auth/login',
//       data: {
//         'username': username,
//         'password': password
//       },
//       queryParameters: {'apikey': 'YOUR_API_KEY'},
//     );
//     //returns the successful user data json object
//     return response.data;
//   } on DioError catch (e) {
//     //returns the error object if any
//     return e.response!.data;
//   }
// }
}
