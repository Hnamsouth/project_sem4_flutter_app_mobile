import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  _dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
  // Assuming the token is stored in the local storage
  String token = 'YOUR_TOKEN_HERE'; // Retrieve your token here
  options.headers['Authorization'] = 'Bearer $token';
  return handler.next(options); // Continue with the request
  },
  ));
}
