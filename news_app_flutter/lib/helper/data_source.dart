import 'package:news_app_flutter/model/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=3a5bf7bfd2b24bdd96878d37e760feb4";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
            news.add(article);
        }
      });
    }
  }
}