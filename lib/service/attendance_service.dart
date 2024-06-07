import 'api_service.dart';
import 'package:dio/dio.dart';


class AttendanceService{
  static Future<List<dynamic>> getAttendance(int id) async {
    try {
      final Response response = await DioService().get("/student/get-attendance?studentYearInfoId=$id");
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception(
            'Failed to load attendance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}