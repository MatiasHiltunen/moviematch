import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  String currentTitle = "Loading...";

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  // Add import to top of the file: import 'package:http/http.dart' as http;
  Future<void> getPopularMovies() async {
    final Uri url = Uri.parse("https://api.themoviedb.org/3/movie/popular");

    var response = await http.get(
      url,
      headers: {
        "Authorization":
            "Bearer ADD_THE_MOVIE_API_READ_ACCESS_TOKEN_FROM_MOODLE_HERE",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    var data = jsonDecode(response.body) as Map<String, dynamic>;

    List movies = data["results"];

    List<String> titles =
        movies.map((movie) {
          return movie["original_title"] as String;
        }).toList();

    currentTitle = titles.first;
    notifyListeners();
  }

  /* 
  {
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg",
      "genre_ids": [
        10749,
        878,
        53
      ],
      "id": 950396,
      "original_language": "en",
      "original_title": "The Gorge",
      "overview": "Two highly trained operatives grow close from a distance after being sent to guard opposite sides of a mysterious gorge. When an evil below emerges, they must work together to survive what lies within.",
      "popularity": 2462.807,
      "poster_path": "/7iMBZzVZtG0oBug4TfqDb9ZxAOa.jpg",
      "release_date": "2025-02-13",
      "title": "The Gorge",
      "video": false,
      "vote_average": 7.83,
      "vote_count": 1365
    },
   */
}
