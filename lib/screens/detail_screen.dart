import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/movie.dart';
import '../services/constants.dart';
import 'favourite_movie_page.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.movie});

  final Movie movie;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late List<Movie> favoriteMovies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(top: 16, left: 16),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            backgroundColor: Colors.blueGrey[900],
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 20),
              centerTitle: true,
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${widget.movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    widget.movie.overview,
                    style: GoogleFonts.abhayaLibre(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border(
                          top: BorderSide(width: 1.0, color: Colors.white)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFBC02D),
                        ),
                        Text(
                          widget.movie.voteAverage.toString(),
                          style: GoogleFonts.abhayaLibre(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Release date: ${widget.movie.getReleaseDateTime().year}',
                          style: GoogleFonts.abhayaLibre(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                            onPressed: () {
                              addToFavorites(widget.movie);
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addToFavorites(Movie movie) {
    if (!favoriteMovies.contains(movie)) {
      favoriteMovies.add(movie);
    }
    Get.to(FavouritePage(favoriteMovies: favoriteMovies));
  }
}
