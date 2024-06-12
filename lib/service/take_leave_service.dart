import 'api_service.dart';
import 'package:dio/dio.dart';

import 'package:project_sem4_flutter_app_mobile/service/api_service.dart';


class TakeLeaveService{

  static Future<List<dynamic>> getTakeLeave(int id) async {
    try {
      final Response response = await DioService().get("/student/get-take-leave?studentId=$id");
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