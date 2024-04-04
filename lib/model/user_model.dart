import 'package:project_sem4_flutter_app_mobile/model/permissions_model.dart';
import 'package:project_sem4_flutter_app_mobile/model/roles_model.dart';
import 'package:project_sem4_flutter_app_mobile/model/userDetails_model.dart';

import 'authRespone_model.dart';

class User {
  User({
    this.id,
    this.username,
    this.authResponse,
    this.roles,
    this.permissions,
    this.userDetail,
  });
  late int? id;
  late String? username;
  late AuthResponse? authResponse;
  late List<Roles>? roles;
  late List<Permissions>? permissions;
  late UserDetail? userDetail;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    authResponse = AuthResponse.fromJson(json['authResponse']);
    roles = List.from(json['roles']).map((e) => Roles.fromJson(e)).toList();
    permissions = List.from(json['permissions'])
        .map((e) => Permissions.fromJson(e))
        .toList();
    userDetail = UserDetail.fromJson(json['userDetail']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['authResponse'] = authResponse?.toJson();
    _data['roles'] = roles?.map((e) => e.toJson()).toList();
    _data['permissions'] = permissions?.map((e) => e.toJson()).toList();
    _data['userDetail'] = userDetail?.toJson();
    return _data;
  }

// to string
  @override
  String toString() {
    return 'LoginResponse{id: $id, username: $username, authResponse: $authResponse, roles: $roles, permissions: $permissions,userDetail:$userDetail}';
  }
}
