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
}
