

import 'package:project_sem4_flutter_app_mobile/model/action/article_model.dart';

import 'api_service.dart';
import 'package:dio/dio.dart';

class ArticleService {

  Future<List<ArticleModel>> getAllArticles() async {
    try {
      final response = await DioService().get("/articles");
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = response.data;
        return jsonResponse.map((article) => ArticleModel.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }
}

