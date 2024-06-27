class Endpoints {
  Endpoints._();

  static const String baseURL = "http://222.252.48.139:4869/api/v1";
  static const String authenticationLoginUrl = '/auth/login';
  static const String authenticationRefreshToken = '/auth/refresh-token';
  static const int receiveTimeout = 5000;

  static const int connectionTimeout = 10000;
}
