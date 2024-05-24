import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/model/student_info.dart';

import '../service/student_service.dart';

// class StudentController extends GetxController {
//   final studentRecord = StudentRecord().obs;
//
//   setStudentRecord(StudentRecord setStudentRecord){
//     studentRecord.update((val) {
//       val?.id = setStudentRecord.id;
//       val?.schoolYearClass = setStudentRecord.schoolYearClass;
//       val?.students = setStudentRecord.students;
//
//     });
//   }
// }


class StudentController extends GetxController {
  var studentRecord = StudentRecord().obs;

  void setStudentRecord(StudentRecord student) {
    studentRecord.value = student;
  }

  Future<void> updateStudentRecord(int userId) async {
    var student = await StudentService.getOne(userId);
    setStudentRecord(student);
  }
}
