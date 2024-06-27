

import 'package:dio/dio.dart';
import 'package:project_sem4_flutter_app_mobile/model/student/point_model.dart';
import 'api_service.dart';

class PointService{


  static Future<PointModel> getPoint(int id) async {
    try {
      final Response response = await DioService().get("/student-score/get-student-score-subject-by?studentYearInfoId=$id");
      if (response.statusCode == 200) {
        return PointModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load schedule. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}