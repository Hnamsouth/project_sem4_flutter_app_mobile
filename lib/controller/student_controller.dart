import 'package:get/get.dart';
import 'package:project_sem4_flutter_app_mobile/model/student/student_info.dart';

import '../service/student_service.dart';



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
