import 'package:dio/dio.dart';

import '../models/newsResponse.dart';

class NewsApiServices {
  final String _url =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=68d739da303c412184eda0a77b811b3d";

  Dio? _dio;

  NewsApiServices() {
    _dio = Dio();
  }

  Future<List<Article>> fetchNewsArticle() async {
    try {
      final response = await _dio!.get(_url);
      if (response.statusCode == 200) {
        final News news = News.fromJson(response.data);
        return news.articles;
      } else {
        print("Failed to fetch news data. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch news data");
      }
    } catch (error) {
      print("An error occurred: $error");
      rethrow;
    }
  }
}
