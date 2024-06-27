class AuthResponse {
  AuthResponse({
    required this.token,
    required this.refreshToken,
  });
  late final String token;
  late final String refreshToken;

  AuthResponse.fromJson(Map<String, dynamic> json){
    token = json['token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['refresh_token'] = refreshToken;
    return _data;
  }
}
