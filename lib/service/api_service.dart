import 'package:dio/dio.dart';
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
          // final prefs = await SharedPreferences.getInstance();
          // // // Get token from secure storage
          // String accessToken = prefs.getString('access-token') ?? "";
          // String refreshToken = prefs.getString('refresh-token') ?? "";
          // print('$accessToken \n $refreshToken');
          // if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
          //   options.headers['Authorization'] = 'Bearer $accessToken';
          // }
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final prefs = await SharedPreferences.getInstance();
            // // Get token from secure storage
            String rfToken = prefs.getString('refresh-token') ?? "";
            if (rfToken.isNotEmpty) {
              // call refresh token
              await refreshToken(rfToken);
              RequestOptions options = e.requestOptions;
              try {
                var resp = await _dio.request(e.requestOptions.path,
                    data: options.data,
                    cancelToken: options.cancelToken,
                    onReceiveProgress: options.onReceiveProgress,
                    onSendProgress: options.onSendProgress,
                    queryParameters: options.queryParameters);
                return handler.resolve(resp);
              } on DioException catch (error) {
                return handler.reject(error);
              }
              //   } else {
              //     return handler.reject(e);
            }
          }
          Logger().e(e);
          return handler.next(e); //continue
        },
      ));
  }
  // refresh token
  Future<void> refreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      Logger().w("calling refresh-token");
      await _dio
          .post("/auth/refresh-token",
              options: Options(headers: {
                'Authorization': 'Bearer $refreshToken',
              }))
          .then((value) async {
        AuthResponse data = AuthResponse.fromJson(value.data);
        await prefs.setString('access-token', data.token);
        await prefs.setString('refresh-token', data.refreshToken);
        Logger().i(data.toString());
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  // get method
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  // post method
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
