class SchoolYear {
  int id;
  DateTime startSem1;
  DateTime startSem2;
  DateTime end;

  SchoolYear({
    required this.id,
    required this.startSem1,
    required this.startSem2,
    required this.end,
  });

  factory SchoolYear.fromJson(Map<String, dynamic> json) => SchoolYear(
    id: json['id'],
    startSem1: DateTime.parse(json['startSem1']),
    startSem2: DateTime.parse(json['startSem2']),
    end: DateTime.parse(json['end']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'startSem1': startSem1.toIso8601String(),
    'startSem2': startSem2.toIso8601String(),
    'end': end.toIso8601String(),
  };
}
