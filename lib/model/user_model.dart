class User {
  final int id;
  final String username;
  final String password;
  final String? token;
  final DateTime created_at;
  final bool status;
  User({
    required this.id,
    required this.username,
    required this.password,
    this.token,
    required this.created_at,
    required this.status,
  });
  // copy
  User copy({
    int? id,
    String? username,
    String? password,
    String? token,
    DateTime? created_at,
    bool? status,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        token: token ?? this.token,
        created_at: created_at ?? this.created_at,
        status: status ?? this.status,
      );
  // toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'token': token,
        'created_at': created_at,
        'status': status,
      };
  // fromJson
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      token: json['token'],
      created_at: json['created_at'],
      status: json['status'],
    );
  }
}
