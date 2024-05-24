import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:project_sem4_flutter_app_mobile/model/schedule_model.dart';

import '../data/constants.dart';
import 'api_service.dart';

class ScheduleService {
  static Future<List<dynamic>> getSchedule(int id) async {
    try {
      final Response response = await DioService().get("/schedule?classId=$id");
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception(
            'Failed to load schedule. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

