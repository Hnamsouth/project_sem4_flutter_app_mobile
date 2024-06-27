import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/controller/user_controller.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/main.dart';
import 'package:project_sem4_flutter_app_mobile/model/auth/authRespone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/auth/user_model.dart';
import 'api_service.dart';
import 'iservice.dart';
import 'package:logger/logger.dart';

class UserService implements Iservice<User> {
  static final UserController userController = Get.put(UserController());

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

  static Future<User?> login(dynamic data, LoginType loginType) async {
    var user = {"username": "phuhuynh1e", "password": "123456"};
    try {
      var result = await DioService().post("/auth/login", data: data);
      if (result.statusCode == 200) {
        User data = User.fromJson(result.data);
        Logger().i(data);
        if (loginType == LoginType.phuhuynh) {
          return checkRole(data, Role.ROLE_PH) ? data : null;
        } else if (loginType == LoginType.giaovien) {
          return checkRole(data, Role.ROLE_GV) ? data : null;
        } else {
          return null;
        }
      }
    } on DioException catch (e) {
      Logger().e("Dio exception: $e.message");
    } catch (e) {
      Logger().e("exception: $e.message");
    }
    return null;
  }

  static bool checkRole(User data, Role role) {
    var check = data.roles?.map((e) => e.name.contains(role.name));
    if (check!.contains(true)) {
      Logger().i(check.toString());
      saveLocalToken(data.authResponse);
      return true;
    }
    return false;
  }

  static void saveLocalToken(AuthResponse? auth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TokenType.accress_token.name, auth!.token);
    await prefs.setString(TokenType.refresh_token.name, auth.refreshToken);
  }

  static Future<bool> loginToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(TokenType.accress_token.name);
    if (accessToken != null) {
      var result = await DioService().post("/auth/login-token");
      if (result.statusCode == 200) {
        User data = User.fromJson(result.data);
        userController.setUser(data);
        return true;
      }
    }
    return false;
  }

  // logout
  static Future<void> logout() async {
    userController.setUser(User());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access-token');
    await prefs.remove('refresh-token');
  }
}
