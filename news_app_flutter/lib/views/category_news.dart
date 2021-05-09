import 'package:flutter/material.dart';
import 'package:news_app_flutter/helper/data_source.dart';
import 'package:news_app_flutter/model/article.dart';

import 'article_webview.dart';


class CategoryNews extends StatefulWidget {
  final String categoryName;

  const CategoryNews({this.categoryName});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();

}

class _CategoryNewsState extends State<CategoryNews> {
  bool _loading = true;
  List<Article> articles = new List<Article>();

  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    CategoryNewsSource _news = CategoryNewsSource();
    await _news.getCategoryNews(widget.categoryName.toLowerCase());
    articles = _news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          actions: [
            Opacity(opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.save)),
            )
          ],
        ),
        body: _loading ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        debugPrint('articles:$articles');
                        return NewsTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            description: articles[index].description,
                            articleUrl: articles[index].articleUrl
                        );
                      }),
                )
              ],
            ),
          ),
        )
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, title, description, content, articleUrl;

  NewsTile({this.imageUrl, this.title, this.description, this.content,
      this.articleUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ArticleWebView(postUrl: articleUrl, postTitle: title)));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery
              .of(context)
              .size
              .width,

          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        this.imageUrl,
                        height: 200,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(height: 12,),
                  Text(
                    this.title,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    this.description,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}