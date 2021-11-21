import 'package:news_app_flutter/model/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class News {
  List<Article> news = [];

  Future<void> getNews() async {
   
    String url = "Find Your Own Api Key";

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

class CategoryNewsSource{
  List<Article> news = [];

  Future<void> getCategoryNews(String categoryName) async {
    //기존
    String url = "https://newsapi.org/v2/top-headlines?category=$categoryName&country=kr&apiKey=d36bcea1cd6b4b40a2db2d9bddf57ee6";
    //String url = "https://newsapi.org/v2/top-headlines?category=$categoryName&country=kr&sortBy=publishedAt&language=kr&apiKey=d36bcea1cd6b4b40a2db2d9bddf57ee6";

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
