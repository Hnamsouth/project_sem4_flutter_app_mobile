import 'package:project_sem4_flutter_app_mobile/model/student/student_year_homework.dart';
import 'package:project_sem4_flutter_app_mobile/model/student/subject_model.dart';

import '../teacher/teacher_infor.dart';

class HomeWorkModel {
  int? id;
  String? title;
  String? content;
  DateTime? dueDate;
  String? description;
  String? url;
  bool? status;
  String? statusName;
  bool? overdue;
  List<String>? homeworkImageUrls;
  List<StudentYearHomeWorks>? studentYearHomeWorks;
  bool? submission;
  Subject? subject;
  TeacherInfo? teacherInfo;

  HomeWorkModel(
      {this.id,
      this.title,
      this.content,
      this.dueDate,
      this.description,
      this.url,
      this.status,
      this.statusName,
      this.overdue,
      this.homeworkImageUrls,
      this.studentYearHomeWorks,
      this.submission,
      this.subject,
      this.teacherInfo});

  HomeWorkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    dueDate = DateTime.parse(json['dueDate']);
    description = json['description'];
    url = json['url'];
    status = json['status'];
    statusName = json['statusName'];
    overdue = json['overdue'];
    if (json['homeworkImageUrls'] != null) {
      homeworkImageUrls = List<String>.from(json['homeworkImageUrls']);
    } else {
      homeworkImageUrls = []; // Gán một danh sách rỗng nếu homeworkImageUrls là null
    }

    if (json['studentYearHomeWorks'] != null) {
      studentYearHomeWorks = <StudentYearHomeWorks>[];
      json['studentYearHomeWorks'].forEach((v) {
        studentYearHomeWorks!.add(new StudentYearHomeWorks.fromJson(v));
      });
    }

    submission = json['submission'];
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    teacherInfo = json['teacherInfo'] != null
        ? new TeacherInfo.fromJson(json['teacherInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['dueDate'] = this.dueDate?.toIso8601String();
    data['description'] = this.description;
    data['url'] = this.url;
    data['status'] = this.status;
    data['statusName'] = this.statusName;
    data['overdue'] = this.overdue;
    data['homeworkImageUrls'] = this.homeworkImageUrls;
    if (this.studentYearHomeWorks != null) {
      data['studentYearHomeWorks'] =
          this.studentYearHomeWorks!.map((v) => v.toJson()).toList();
    }
    data['submission'] = this.submission;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.teacherInfo != null) {
      data['teacherInfo'] = this.teacherInfo!.toJson();
    }
    return data;
  }
}




