import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:netflixclone/utils/api.dart';
import 'package:provider/provider.dart';

class MoviesProvider extends ChangeNotifier {
  List popular = [];
  List topRated = [];
  List categories = [
    {
      "id": 28,
      "name": "Action",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/3OXiTjU30gWtqxmx4BU9RVp2OTv.jpg"
    },
    {
      "id": 12,
      "name": "Adventure",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/9dKCd55IuTT5QRs989m9Qlb7d2B.jpg"
    },
    {
      "id": 16,
      "name": "Animation",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/4j0PNHkMr5ax3IA8tjtxcmPU3QT.jpg"
    },
    {
      "id": 35,
      "name": "Comedy",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg"
    },
    {
      "id": 99,
      "name": "Documentary",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/jntLBq0MLR3hrwKaTQswxACRPMs.jpg"
    },
    {
      "id": 18,
      "name": "Drama",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/1SOiUTDnwW9gU4GzSIsOCQUlHJF.jpg"
    },
    {
      "id": 14,
      "name": "Fantasy",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/3mFM80dPzSqoXXuC2UMvLIRWX32.jpg"
    },
    {
      "id": 27,
      "name": "Horror",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/xbSuFiJbbBWCkyCCKIMfuDCA4yV.jpg"
    },
    {
      "id": 9648,
      "name": "Mystery",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/vclShucpUmPhdAOmKgf3B3Z4POD.jpg"
    },
    {
      "id": 10749,
      "name": "Romance",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/dU4HfnTEJDf9KvxGS9hgO7BVeju.jpg"
    },
    {
      "id": 878,
      "name": "Sci-Fi",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"
    },
    {
      "id": 53,
      "name": "Thriller",
      "image":
          "https://www.themoviedb.org/t/p/w220_and_h330_face/iUgygt3fscRoKWCV1d0C7FbM9TP.jpg"
    },
  ];

  List searchResult = [];
  List categoryMovies = [];
  Map movieDetails = {};

  bool searchingMovie = false;

  List posterUrls = [];

  getPopular() async {
    var response = await http.get(Uri.parse(
        "$tmdbUrl/movie/popular" + tmdbApiKey + "&language=en-US&page=1"));
    popular = jsonDecode(response.body)["results"];
    for (int i = 0; i < 4; i++) {
      posterUrls.add("https://image.tmdb.org/t/p/original" +
          popular[i]["poster_path"]);
    }
  }

  getTopRated() async {
    var response = await http.get(Uri.parse(
        "$tmdbUrl/movie/top_rated" + tmdbApiKey + "&language=en-US&page=1"));
    topRated = jsonDecode(response.body)["results"];
  }

  searchMovie(String keyword) async {
    var response = await http.get(Uri.parse("$tmdbUrl/search/movie" +
        tmdbApiKey +
        "&language=en-US&page=1&query=" +
        keyword));
    searchResult = jsonDecode(response.body)["results"];
    List newResult = [];
    for(int i = 0; i < searchResult.length; i++){
      if(searchResult[i]["poster_path"] != null){
        newResult.add(searchResult[i]);
      }
    }
    searchResult = newResult;
    notifyListeners();
  }

  getMoviesByCategory(int categoryId) async {
    var response = await http.get(Uri.parse("$tmdbUrl/discover/movie" +
        tmdbApiKey +
        "&language=en-US&page=1&with_genres=" +
        categoryId.toString()));
    categoryMovies = jsonDecode(response.body)["results"];
  }

  getMovieDetails(String movieId) async {
    var response = await http.get(Uri.parse(
        "$tmdbUrl/movie/" + movieId + tmdbApiKey + "&language=en-US&page=1"));
    movieDetails = jsonDecode(response.body);
  }
}
