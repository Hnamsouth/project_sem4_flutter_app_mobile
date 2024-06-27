class Schedule {
  int? id;
  int? indexLesson;
  String? studyTime;
  String? dayOfWeek;
  String? note;
  int? teacherSchoolYearId;
  int? schoolYearClassId;
  int? schoolYearSubjectId;
  String? teacherName;
  String? className;
  String? subjectName;

  Schedule(
      {this.id,
        this.indexLesson,
        this.studyTime,
        this.dayOfWeek,
        this.note,
        this.teacherSchoolYearId,
        this.schoolYearClassId,
        this.schoolYearSubjectId,
        this.teacherName,
        this.className,
        this.subjectName});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indexLesson = json['indexLesson'];
    studyTime = json['studyTime'];
    dayOfWeek = json['dayOfWeek'];
    note = json['note'];
    teacherSchoolYearId = json['teacherSchoolYearId'];
    schoolYearClassId = json['schoolYearClassId'];
    schoolYearSubjectId = json['schoolYearSubjectId'];
    teacherName = json['teacherName'];
    className = json['className'];
    subjectName = json['subjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['indexLesson'] = this.indexLesson;
    data['studyTime'] = this.studyTime;
    data['dayOfWeek'] = this.dayOfWeek;
    data['note'] = this.note;
    data['teacherSchoolYearId'] = this.teacherSchoolYearId;
    data['schoolYearClassId'] = this.schoolYearClassId;
    data['schoolYearSubjectId'] = this.schoolYearSubjectId;
    data['teacherName'] = this.teacherName;
    data['className'] = this.className;
    data['subjectName'] = this.subjectName;
    return data;
  }
}
