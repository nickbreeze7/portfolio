import 'package:flutter_movies_app/model/movie_details.dart';
import 'package:flutter_movies_app/model/movie_preview.dart';
import 'package:flutter_movies_app/secret/themoviedb_api.dart' as secret;
import 'package:flutter_movies_app/utils/constants.dart';
import 'package:flutter_movies_app/utils/file_manager.dart';
import 'package:flutter_movies_app/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'networking.dart';



enum MoviePageType{
  popular,
  upcoming,
  top_rated,
}

class MovieModel{
  Future _getData({required String url}) async {
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(url));
    var data = await networkHelper.getData();
    return data;
  }

  Future<List<MovieCard>> getMovies({
    required MoviePageType moviesType,
    required Color themeColor,
  }) async {
    List<MovieCard> temp = [];
    String mTypString =
        moviesType.toString().substring(14, moviesType.toString().length);

    var data = await _getData(
      url: '$kThemoviedbURL/$mTypString?api_key=${secret.themoviedbApi}',
    );

    for(var item in data["results"]){
      temp.add(
        MovieCard(
          moviePreview: MoviePreview(
          isFavorite:
              await isMovieInFavorites(movieID: item["id"].toString()),
          year: (item["release_date"].toString().length > 4)
            ? item["release_date"].toString().substring(0,4)
              : "",
          imageUrl: "$kThemoviedbImageURL${item["poster_path"]}",
          title: item["title"],
          id: item["id"].toString(),
          rating: item["vote_average"].toDouble(),
          overview: item["overview"],
        ),
            themeColor: themeColor,
        ),
      );
    }
      return Future.value(temp);
  }

  Future<List<MovieCard>> searchMovies({
    required String movieName,
    required Color themeColor,
  }) async {
    List<MovieCard> temp = [];

    var data = await _getData(
        url:
          '$kThemoviedbSearchURL/?api_key=${secret.themoviedbApi}&language=en-US&page=1&include_adult=false&query=$movieName',
    );
    for(var item in data["results"]){
      try {
        temp.add(
          MovieCard(
            moviePreview: MoviePreview(
              isFavorite: await isMovieInFavorites(movieID: item["id"].toString()),
              year: (item["release_date"].toString().length > 4)
                  ? item["release_date"].toString().substring(0,4)
                  :"",
              imageUrl: "https://image.tmdb.org/t/p/w500${item["poster_path"]}",
              title: item["title"],
              id: item["id"].toString(),
              rating: item["vote_average"].toDouble(),
              overview: item["overview"],
          ),
              themeColor: themeColor,
          ),
        );
      } catch( e, s){
        print(s);
        print(item["release_date"]);
      }
    }
      return Future.value(temp);
  }


    Future<MovieDetails> getMovieDetails({required String movieID}) async {
    var data = await _getData(
        url: '$kThemoviedbURL/$movieID?api_key=${secret.themoviedbApi}&language=en-US',
    );
    List<String> temp = [];
    for(var item in data["genres"]) {
      temp.add(item["name"]);
    }

    return Future.value(
      MovieDetails(
          backgroundURL: "https://image.tmdb.org/t/p/w500${data["backdrop_path"]}",
          title: data["title"],
          year: (data["release_date"].toString().length > 4)
              ? data["release_date"].toString().substring(0, 4)
              : "",
          isFavorite: await isMovieInFavorites(movieID: data["id"].toString()),
          rating: data["vote_average"].toDouble(),
          genres: temp,
          overview: data["overview"],
      ),
    );
    }

    Future<List<MovieCard>> getFavorites({
      required Color themeColor , required int bottomBarIndex}) async {
    List<MovieCard> temp = [];
    List<String> favoritesID = await getFavoritesID();
    for(var item in favoritesID){
      if(item != ""){
        var data = await _getData(
          url:
             '$kThemoviedbURL/$item?api_key=${secret.themoviedbApi}&language=en-US',
        );

        temp.add(
          MovieCard(
            contentLoadedFromPage: bottomBarIndex,
            themeColor: themeColor,
            moviePreview: MoviePreview(
              isFavorite:
                   await isMovieInFavorites(movieID: data["id"].toString()),
              year: (data["release_date"].toString().length > 4)
                  ? data["release_date"].toString().substring(0, 4)
                  : "",
              imageUrl: "https://image.tmdb.org/t/p/w500${data["poster_path"]}",
              title: data["title"],
              id: data["id"].toString(),
              rating: data["vote_average"].toDouble(),
              overview: data["overview"],
            ),
          ),
        );
      }
    }
    return temp;
    }
}
