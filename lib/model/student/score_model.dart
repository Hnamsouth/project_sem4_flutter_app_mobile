class Score {
  String? score;
  int? semester;
  int? id;
  String? pointType;
  String? semesterName;

  Score(
      {this.score, this.semester, this.id, this.pointType, this.semesterName});

  Score.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    semester = json['semester'];
    id = json['id'];
    pointType = json['pointType'];
    semesterName = json['semesterName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['semester'] = this.semester;
    data['id'] = this.id;
    data['pointType'] = this.pointType;
    data['semesterName'] = this.semesterName;
    return data;
  }
}
