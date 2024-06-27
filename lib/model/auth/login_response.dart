import 'package:project_sem4_flutter_app_mobile/model/auth/userDetails_model.dart';

class LoginResponse {
  final int id;
  final String username;
  final AuthResponse authResponse;
  final List<Role> roles;
  final List<Permission> permissions;
  final  UserDetail? userDetail;


  LoginResponse({
    required this.id,
    required this.username,
    required this.authResponse,
    required this.roles,
    required this.permissions,
    required this.userDetail,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      username: json['username'],
      authResponse: AuthResponse.fromJson(json['authResponse']),
      roles: (json['roles'] as List).map((i) => Role.fromJson(i)).toList(),
      permissions: (json['permissions'] as List)
          .map((i) => Permission.fromJson(i))
          .toList(),
        userDetail : UserDetail.fromJson(json['userDetail'])

    );
  }
  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'authResponse': authResponse,
        'roles': roles,
        'permissions': permissions,
        'userDetail': userDetail,
      };
  // to string
  @override
  String toString() {
    return 'LoginResponse{id: $id, username: $username, authResponse: $authResponse, roles: $roles, permissions: $permissions,userDetail:$userDetail}';
  }
}

class AuthResponse {
  final String token;
  final String refreshToken;

  AuthResponse({
    required this.token,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      refreshToken: json['refresh_token'],
    );
  }
  // to json
  Map<String, dynamic> toJson() => {
        'token': token,
        'refreshToken': refreshToken,
      };
  // to string
  @override
  String toString() {
    return 'AuthResponse{token: $token, refreshToken: $refreshToken}';
  }
}

class Role {
  final int id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Permission {
  final int id;
  final String name;

  Permission({
    required this.id,
    required this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      name: json['name'],
    );
  }
}
