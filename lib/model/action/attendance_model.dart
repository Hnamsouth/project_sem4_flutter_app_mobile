import 'package:project_sem4_flutter_app_mobile/model/student/student_info.dart';

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


// Widget _buildAttendance() {
//   return FutureBuilder<List<AttendanceList>>(
//     future: futureAttendance,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text('Error: ${snapshot.error}'));
//       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return Center(child: Text('No attendance data available.'));
//       } else {
//         final attendances = snapshot.data!;
//         return ListView.builder(
//           itemCount: _recentDates.length,
//           itemBuilder: (context, index) {
//             final date = _recentDates[index];
//             return Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(date),
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       studentController.studentRecord.value.students
//                           ?.getFullName() ??
//                           'Unknown',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 4.0),
//                     Row(
//                       children: [
//                         Text(
//                           'Trạng thái: ',
//                           style: TextStyle(
//                             fontSize: 16.0,
//                           ),
//                         ),
//                         Text(
//                           _getAttendanceStatus(attendances, date),
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Người điểm danh: ${_getTeacherName()}',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }
//     },
//   );
// }





