import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app_flutter/helper/catetory_data_source.dart';
import 'package:news_app_flutter/helper/data_source.dart';
import 'package:news_app_flutter/model/article.dart';
import 'package:news_app_flutter/model/category.dart';
import 'package:news_app_flutter/views/category_news.dart';
import 'package:news_app_flutter/widget/category_tile.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState  extends State<Home>{
  bool _loading = true;
  List<Category> catList = new List<Category>();
  List<Article> articles = new List<Article>();

  @override
  void initState(){
    catList = getCategories();
    getNews();
    super.initState();
  }

   getNews() async {
    News _news = News();
    await _news.getNews();
    articles = _news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News", style: TextStyle(
              letterSpacing: 3
            ),
            ),
            Text("World", style: TextStyle(
              color: Colors.blue,
              letterSpacing: 0
            ),
            )
          ],
        ),
        centerTitle: True,
        elevation: 0.0,
      ),
      body: _loading? Center(
        child: Container{
          child:Column(
          children: <Widget>[
            Container(
            height: 80,
            child:ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount:catList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return CategoryTile(
                  catList[index].catImage,
                  catList[index].catName
                );
        },
      ),
      ),
      //ARTICLES
      SizedBox((height:12, ),
        Column(
        children: <Widget>[
          SizedBox(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Today's HighLights",
              textAlign: TextAlign.left,
            style: TextStyle(
            fontSize: 22,
            color:Colors.black,
            fontWeight: FontWeight.w500
      ),
      ),
          ),
      ),
      ],
      ),
      SizedBox(height: 12,),
      ListView.builder(
        itemCount: articles.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index){
          debugPrint('articles:$articles');
          log('articles: $articles');

          return NewsTile(
          imageUrl:article[index].urlToImage,
          title:articles[index].title,
          description:articles[index].description,
          articleUrl:articles[index].articleUrl
        );
      })
      ],
      ),
    ),
      ),
    );
  }
  }