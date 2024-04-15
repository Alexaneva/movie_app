import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/services/api_service.dart';

import '../models/movie.dart';
import '../services/constants.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Movie> snapshot = [];

  late Future<List<Movie>> nowPlayingMovies;
  List<Movie> movies = [];
  List<Movie> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    nowPlayingMovies = ApiService().nowPlaying();
    nowPlayingMovies.then((value) {
      setState(() {
        snapshot = value;
        movies = value;
        filteredMovies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: searchController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.search),
                  labelText: 'Search for movies',
                  labelStyle: GoogleFonts.aBeeZee(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: _filterMovies,
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: filteredMovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int itemIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailScreen(movie: snapshot[itemIndex]));
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 140,
                                width: 200,
                                child: Image.network(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    '${Constants.imagePath}${filteredMovies[itemIndex].posterPath}'),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                filteredMovies[itemIndex].title,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _filterMovies(String query) {
    List<Movie> searchResult = movies
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredMovies = searchResult;
    });
  }
}
