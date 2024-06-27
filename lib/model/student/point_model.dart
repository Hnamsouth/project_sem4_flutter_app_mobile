class PointModel {
  List<StudentScoreSubject>? semester1;
  List<StudentScoreSubject>? semester2;
  List<StudentScoreSubject>? summary;

  PointModel({this.semester1, this.semester2, this.summary});

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      semester1: (json['semester1'] as List<dynamic>?)
          ?.map((e) => StudentScoreSubject.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      semester2: (json['semester2'] as List<dynamic>?)
          ?.map((e) => StudentScoreSubject.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      summary: (json['summary'] as List<dynamic>?)
          ?.map((e) => StudentScoreSubject.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class StudentScoreSubject {
  SchoolYearSubject schoolYearSubject;
  StudentScores studentScores;

  StudentScoreSubject({required this.schoolYearSubject, required this.studentScores});

  factory StudentScoreSubject.fromJson(Map<String, dynamic> json) {
    return StudentScoreSubject(
      schoolYearSubject: SchoolYearSubject.fromJson(json['schoolYearSubject']),
      studentScores: StudentScores.fromJson(json['studentScores']),
    );
  }
}

class SchoolYearSubject {
  String name;

  SchoolYearSubject({required this.name});

  factory SchoolYearSubject.fromJson(Map<String, dynamic> json) {
    return SchoolYearSubject(
      name: json['name'] ?? '',
    );
  }
}

class StudentScores {
  List<Score> KTTX;
  List<Score> KT_GIUA_KY;
  List<Score> KT_CUOI_KY;
  List<Score> DTB;

  StudentScores({
    required this.KTTX,
    required this.KT_GIUA_KY,
    required this.KT_CUOI_KY,
    required this.DTB,
  });

  factory StudentScores.fromJson(Map<String, dynamic> json) {
    return StudentScores(
      KTTX: (json['KTTX'] as List<dynamic>?)
          ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      KT_GIUA_KY: (json['KT_GIUA_KY'] as List<dynamic>?)
          ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      KT_CUOI_KY: (json['KT_CUOI_KY'] as List<dynamic>?)
          ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      DTB: (json['DTB'] as List<dynamic>?)
          ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class Score {
  String score;

  Score({required this.score});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      score: json['score'] ?? '',
    );
  }
}
