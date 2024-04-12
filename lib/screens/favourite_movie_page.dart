import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: widget.favoriteMovies.length,
          itemBuilder: (context, index) {
            Movie movie = widget.favoriteMovies[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      removeFromFavorites(movie);
                    },
                    backgroundColor: Colors.black,
                    icon: Icons.delete,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      goToDetails(movie);
                    },
                    backgroundColor: Colors.black,
                    icon: Icons.remove_red_eye,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    '${Constants.imagePath}${movie.posterPath}',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    movie.title,
                    style: GoogleFonts.abhayaLibre(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void removeFromFavorites(Movie movie) {
    setState(() {
      widget.favoriteMovies.remove(movie);
    });
  }

  void goToDetails(Movie movie) {
    Get.to(DetailScreen(
      movie: movie,
    ));
  }
}
