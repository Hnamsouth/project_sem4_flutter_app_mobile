// import 'package:project_sem4_flutter_app_mobile/model/user_model.dart';
// import 'package:dio/dio.dart';
//
// abstract class ILogin{
//   Future<User> login(String username, String password) async {
//     const api = 'https://reqres.in/api/login';
//     final data = {"username": username, "password": password};
//     final dio = Dio();
//     Response response;
//     response = await dio.post(api, data: data);
//     if (response.statusCode == 200) {
//       final body = response.data;
//       return User(username: username, token: body['token']);
//     } else {
//       return null;
//     }
//   }
// }