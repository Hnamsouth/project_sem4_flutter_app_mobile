import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:project_sem4_flutter_app_mobile/model/schedule_model.dart';

import '../data/constants.dart';
import 'api_service.dart';

class TransactionService {
  static Future<List<dynamic>> getTransactions(int studentYearInfoId ) async {
    try {
      final Response response = await DioService().get("/student/get-student-transactions?studentYearInfoId=$studentYearInfoId");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to load schedule. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

