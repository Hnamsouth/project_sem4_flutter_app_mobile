import 'package:project_sem4_flutter_app_mobile/model/student/homework_model.dart';

import 'api_service.dart';

class HomeWorkService {
  Future<List<HomeWorkModel>> getAllHomeWork(int id) async {
    try {
      final response = await DioService().get("/getHomeWorkByStudentYearInfoID?id=$id");
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        return jsonResponse.map((homework) => HomeWorkModel.fromJson(homework)).toList();
      } else {
        throw Exception('Có lỗi xảy ra !! Vui lòng thử lại');
      }
    } catch (e) {
      throw Exception('Có lỗi xảy ra !! Vui lòng thử lại : $e');
    }
  }





}