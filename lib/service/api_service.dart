import 'package:dio/dio.dart';
import 'package:project_sem4_flutter_app_mobile/data/constants.dart';
import 'package:project_sem4_flutter_app_mobile/model/login_response.dart';
import 'package:project_sem4_flutter_app_mobile/service/Endpoint.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  Dio _dio = Dio();

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
          final prefs = await SharedPreferences.getInstance();
          // // Get token from secure storage
          String? accessToken = prefs.getString(TokenType.accress_token.name);
          options.headers['Authorization'] = 'Bearer $accessToken';
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 &&
              e.response?.requestOptions.path != authenticationLoginUrl) {
            final prefs = await SharedPreferences.getInstance();
            // // Get token from secure storage
            String? rfToken = prefs.getString(TokenType.refresh_token.name);
            String? accessToken = await refreshToken(rfToken ?? "");
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

  String get authenticationLoginUrl => '';
  // refresh token
  Future<String?> refreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      Logger().w("calling refresh-token");
      var result = await _dio
          .post("/auth/refresh-token",
              options: Options(headers: {
                'Authorization': 'Bearer $refreshToken',
              }))
          .then((value) async {});
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
        await prefs.remove(TokenType.accress_token.name);
        await prefs.remove(TokenType.refresh_token.name);
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
