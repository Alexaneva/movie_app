import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie.dart';
import 'package:get/get.dart';
import '../services/constants.dart';
import 'detail_screen.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({
    super.key,
    required this.favoriteMovies,
  });

  final List<Movie> favoriteMovies;
  late Movie movie;

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Movie> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteMovieStrings =
        prefs.getStringList('favoriteMovies') ?? [];
    setState(() {
      favoriteMovies = favoriteMovieStrings
          .map((e) => Movie.fromJson(jsonDecode(e)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Expanded(
          child: GridView.builder(
            itemCount: favoriteMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              Movie movie = favoriteMovies[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),

                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: Image.network(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              '${Constants.imagePath}${movie.posterPath}'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.title,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Wrap(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                goToDetails(movie);
                              },
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete_forever,
                                  color: Colors.white),
                              onPressed: () {
                                removeFromFavorites(movie);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> removeFromFavorites(Movie movie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteMovies = prefs.getStringList('favoriteMovies') ?? [];
    favoriteMovies.remove(jsonEncode(movie.toJson()));
    prefs.setStringList('favoriteMovies', favoriteMovies);
    loadFavorites();
  }

  void goToDetails(Movie movie) {
    Get.to(DetailScreen(
      movie: movie,
    ));
  }
}
