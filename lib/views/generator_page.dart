import 'package:flutter/material.dart';
import 'package:moviematch/main.dart';
import 'package:moviematch/models/movie.dart';
import 'package:moviematch/providers/app_state.dart';
import 'package:moviematch/providers/moviematch.dart';
import 'package:moviematch/widgets/swipeable_cards.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // Moved to swipeable_cards
    /* var movieMatch = context.read<MovieMatchProvider>(); */

    /* List<Movie> movies = appState.movies; */
    /*    var pair = appState.current; */
    /* String currentTitle = appState.currentTitle; */

    /*    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    } */

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*   Text(currentTitle), */
          /*           TextButton(
            onPressed: () => movieMatch.send(),
            child: Text("Test gRPC"),
          ), */

          /*       TextButton(
            onPressed: () => appState.getPopularMovies(),
            child: Text("Get popular movies"),
          ), */
          FutureBuilder<List<Movie>>(
            future: appState.getPopularMovies(),
            /*   future: () async {
              await appState.getPopularMovies();
              return appState.movies;
            }, */
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError &&
                  snapshot.hasData) {
                /* appState.movies = snapshot.data!; */

                return SwipeableCards(snapshot.data!);
              }

              return Text("No movies at this time :(");
            },
          ),

          /*           SizedBox(
            height: 300,
            child: ListView.builder(
              itemBuilder: (context, index) {
                var image = Image.network(
                  "https://image.tmdb.org/t/p/w500" + movies[index].posterPath,
                );

                return image;

                // return ListTile(title: Text(movies[index].originalTitle));
              },
              itemCount: movies.length,
            ),
          ), */
          /*  BigCard(pair: pair), */
          /*  SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ), */
        ],
      ),
    );
  }
}
