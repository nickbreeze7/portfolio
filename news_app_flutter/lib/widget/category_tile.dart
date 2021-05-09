import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/views/category_news.dart';

class CategoryTile extends StatelessWidget {
  final String imgUrl, label;

  CategoryTile(this.imgUrl, this.label);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            CategoryNews(
              categoryName: label.toString(),)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  height: 60,
                  width: 120,
                  fit: BoxFit.cover
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black45,
              ),
              height: 60,
              width: 120,
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
