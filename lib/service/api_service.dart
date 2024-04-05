import 'package:dio/dio.dart';
import 'package:get/get.dart' as Getx;
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/model/login_response.dart';
import 'package:project_sem4_flutter_app_mobile/service/Endpoint.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  Dio _dio = Dio();
  String? _token;

  DioService() {
    _dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseURL,
      receiveTimeout: const Duration(milliseconds: Endpoints.connectionTimeout),
      connectTimeout: const Duration(milliseconds: Endpoints.receiveTimeout),
      contentType: "application/json",
    ))
      // ..interceptors.add(LogInterceptor(responseBody: true))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          // remoce authorization when login
          Logger().i(options.path);
          if (options.path == Endpoints.authenticationLoginUrl ||
              options.path == Endpoints.authenticationRefreshToken) {
            return handler.next(options);
          }
          if (_token == null) {
            final prefs = await SharedPreferences.getInstance();
            _token = prefs.getString(TokenType.accress_token.name) ?? "";
          }
          options.headers['Authorization'] = 'Bearer $_token';
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 &&
              e.response?.requestOptions.path !=
                  Endpoints.authenticationLoginUrl) {
            //e.response?.requestOptions.path !=Endpoints.authenticationLoginUrl
            final prefs = await SharedPreferences.getInstance();
            // // Get token from secure storage
            String? rfToken = prefs.getString(TokenType.refresh_token.name);
            String? accessToken = await refreshToken(rfToken ?? "", prefs);
            if (accessToken != null) {
              // Update the request header with the new access token
              e.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
              // call refresh token
              return handler.resolve(await _dio.fetch(e.requestOptions));
            }
          }
          Logger().w(e.message);
          return handler.next(e); //continue
        },
      ));
  }

  // refresh token
  Future<String?> refreshToken(
      String refreshToken, SharedPreferences prefs) async {
    try {
      Logger().w("calling refresh-token");
      var result = await Dio().post(
        '${Endpoints.baseURL}${Endpoints.authenticationRefreshToken}',
        options: Options(contentType: 'application/json', headers: {
          'Authorization': 'Bearer $refreshToken',
        }),
      );
      // Check if the response status code is 200 (OK)
      if (result.statusCode == 200) {
        // Parse the response to get the new authentication token
        AuthResponse data = AuthResponse.fromJson(result.data);
        await prefs.setString(TokenType.accress_token.name, data.token);
        await prefs.setString(TokenType.refresh_token.name, data.refreshToken);
        Logger().i(data.toString());
        // Return the new access token
        return data.token;
      } else {
        _token = null;
        await prefs.remove(TokenType.accress_token.name);
        await prefs.remove(TokenType.refresh_token.name);
        Getx.Get.offNamed('/select_action');
      }
      // Return null if the response status code is not 200
      return null;
    } catch (e) {
      Logger().e('Error refreshing authentication token: $e');
      return null;
    }
  }

  // get method
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  // post method,
  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  // put method
  Future<Response> put(String path, {dynamic data}) async {
    return _dio.put(path, data: data);
  }

  // delete method
  Future<Response> delete(String path, {dynamic data}) async {
    return _dio.delete(path, data: data);
  }
}
