import 'package:project_sem4_flutter_app_mobile/model/student_info.dart';

class AttendanceList {
  int? id;
  String? attendanceStatus;
  String? attendanceStatusName;
  String? notificationStatus;
  String? note;
  String? createdAt;

  AttendanceList(
      {this.id,
        this.attendanceStatus,
        this.attendanceStatusName,
        this.notificationStatus,
        this.note,
        this.createdAt,
        });

  AttendanceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceStatus = json['attendanceStatus'];
    attendanceStatusName = json['attendanceStatusName'];
    notificationStatus = json['notificationStatus'];
    note = json['note'];
    createdAt = json['createdAt'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attendanceStatus'] = this.attendanceStatus;
    data['attendanceStatusName'] = this.attendanceStatusName;
    data['notificationStatus'] = this.notificationStatus;
    data['note'] = this.note;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

