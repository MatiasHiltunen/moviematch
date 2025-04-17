import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class SwipeableCards extends StatelessWidget {
  List<Widget> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      child: Text("first"),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.redAccent,
      child: Text("second"),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.amberAccent,
      child: Text("third"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    var movies = appState.movies;

    if (movies.isEmpty) {
      return Text("No movies available");
    }

    return Flexible(
      child: CardSwiper(
        cardBuilder: (context, index, tresholdX, tresholdY) {
          var baseUrl = "https://image.tmdb.org/t/p/w500";
          var posterPath = movies[index].posterPath;
          var fullImageUrl = baseUrl + posterPath;

          return Container(
            alignment: Alignment.center,
            child: Image.network(fullImageUrl),
          );
        },
        cardsCount: movies.length,
      ),
    );
  }
}
