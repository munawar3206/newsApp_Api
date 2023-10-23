import 'package:appnews/models/newsResponse.dart';
import 'package:appnews/services/news_services.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List<Article> articles = <Article>[];
  bool isLoading = true;

  void getAllNews() async {
    articles = await NewsApiServices().fetchNewsArticle();
    isLoading = false;
    notifyListeners();
  }
  
}
