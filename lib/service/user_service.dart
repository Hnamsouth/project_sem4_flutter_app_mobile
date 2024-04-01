import '../model/user_model.dart';
import 'iservice.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  static Future<void> login(dynamic data) async {
    String url = "http://14.248.97.203:4869/api/v1/auth/login";
    final dio = Dio();
    try {
      await dio
          .post(url,
              data: data,
              options: Options(
                headers: {"Content-Type": Headers.jsonContentType},
              ))
          .then((value) {
            print(data);
        final storage = FlutterSecureStorage();
        storage.write(key: 'jwt', value: data.token);
      }).catchError((e) => Logger().e(e));
    } catch (e) {
      Logger().e(e);
    }
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
