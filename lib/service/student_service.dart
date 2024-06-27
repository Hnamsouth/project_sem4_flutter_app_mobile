import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../data/constants.dart';
import '../model/student/student_info.dart';
import 'api_service.dart';

class StudentService {
  static Future<StudentRecord> getOne(int id) async {


    try {
      var result = await DioService().get("/student/get-student-year-info-by?byParentId=$id");
      if (result.statusCode == 200) {
        // Kiểm tra dữ liệu trả về từ API
        if (result.data is List) {
          // Nếu dữ liệu là một danh sách, lấy phần tử đầu tiên
          var data = result.data[0];
          StudentRecord studentRecord = StudentRecord.fromJson(data);
          return studentRecord;
        } else if (result.data is Map<String, dynamic>) {
          // Nếu dữ liệu là một đối tượng duy nhất
          StudentRecord studentRecord = StudentRecord.fromJson(result.data);
          return studentRecord;
        } else {
          throw Exception("Unexpected data format");
        }
      }


    } on DioException catch (e) {
      Logger().e("Dio exception: $e.message");
    } catch (e) {
      Logger().e("exception: $e.message");
    }
    return Future.error(error);
  }

}