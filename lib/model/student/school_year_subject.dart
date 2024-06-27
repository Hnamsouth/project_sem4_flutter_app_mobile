import 'package:project_sem4_flutter_app_mobile/model/student/subject_model.dart';

import '../action/school_year.dart';

class SchoolYearSubject {
  int? id;
  Subject? subject;
  SchoolYear? schoolYear;

  SchoolYearSubject({this.id, this.subject, this.schoolYear});

  SchoolYearSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject =
    json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    schoolYear = json['schoolYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    data['schoolYear'] = this.schoolYear;
    return data;
  }
}
