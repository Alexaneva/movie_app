import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/screens/top_rated_movies.dart';
import 'package:movie_app/screens/trending.dart';
import 'package:movie_app/screens/upcoming_movies.dart';
import 'package:movie_app/screens/widgets/fade_animation.dart';
import 'package:movie_app/services/api_service.dart';

import '../models/movie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatingMovies;
  late Future<List<Movie>> upComingMovie;

  @override
  void initState() {
    super.initState();

    trendingMovies = ApiService().getTrendingMovies();
    topRatingMovies = ApiService().getTopRatedMovies();
    upComingMovie = ApiService().upComingMovie();
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            "MOOVIZ",
            style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontFamily: 'BebasNeue-Regular'),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trending movies",
                  style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  child: FutureBuilder(
                      future: trendingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          return TrendingMovieList(snapshot: snapshot);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                const SizedBox(height: 32),
                Text(
                  "Top rated movies",
                  style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  child: FutureBuilder(
                      future: topRatingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          return TopRatedMovies(snapshot: snapshot);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                const SizedBox(height: 32),
                Text(
                  "UpComing movies",
                  style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  child: FutureBuilder(
                      future: upComingMovie,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          return UpComingMovies(snapshot: snapshot);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
