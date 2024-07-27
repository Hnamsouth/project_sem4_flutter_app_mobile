
import 'package:project_sem4_flutter_app_mobile/model/student/student_info.dart';
import 'package:project_sem4_flutter_app_mobile/model/student/subject_model.dart';
import 'package:project_sem4_flutter_app_mobile/model/teacher/teacher_infor.dart';

class StudentYearHomeWorks {
  int? id;
  String? description;
  String? url;
  String? submitTime;
  bool? status;
  String? statusName;
  double? point;
  StudentInfo? studentYearInfoId;
  List<String>? imageUrl;
  Subject? subjectName;
  TeacherInfo? teacherName;

  StudentYearHomeWorks(
      {this.id,
        this.description,
        this.url,
        this.submitTime,
        this.status,
        this.statusName,
        this.point,
        this.studentYearInfoId,
        this.imageUrl,
        this.subjectName,
        this.teacherName});

  StudentYearHomeWorks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    url = json['url'];
    submitTime = json['submitTime'];
    status = json['status'];
    statusName = json['statusName'];
    point = json['point'];
    studentYearInfoId = json['studentYearInfoId'];
    if (json['imageUrl'] != null) {
      imageUrl = List<String>.from(json['imageUrl']);
    } else {
      imageUrl = []; // Gán một danh sách rỗng nếu homeworkImageUrls là null
    }
    subjectName = json['subjectName'];
    teacherName = json['teacherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['url'] = this.url;
    data['submitTime'] = this.submitTime;
    data['status'] = this.status;
    data['statusName'] = this.statusName;
    data['point'] = this.point;
    data['studentYearInfoId'] = this.studentYearInfoId;
    data['imageUrl'] = this.imageUrl;
    data['subjectName'] = this.subjectName;
    data['teacherName'] = this.teacherName;
    return data;
  }
}











