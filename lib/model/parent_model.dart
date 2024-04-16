class TeacherContact {
  int? teacherSchoolYearId;
  String? name;
  String? email;
  String? phone;
  List<String>? subjects;
  String? teacherType;

  TeacherContact(
      {this.teacherSchoolYearId,
        this.name,
        this.email,
        this.phone,
        this.subjects,
        this.teacherType});

  TeacherContact.fromJson(Map<String, dynamic> json) {
    teacherSchoolYearId = json['teacherSchoolYearId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    subjects = json['subjects'].cast<String>();
    teacherType = json['teacherType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacherSchoolYearId'] = this.teacherSchoolYearId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['subjects'] = this.subjects;
    data['teacherType'] = this.teacherType;
    return data;
  }
}
