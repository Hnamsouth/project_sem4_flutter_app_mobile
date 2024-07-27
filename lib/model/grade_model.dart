class Grade {
  int id;
  String name;

  Grade({
    required this.id,
    required this.name,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
