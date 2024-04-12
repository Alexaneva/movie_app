import 'package:flutter/material.dart';
import 'package:movie_app/screens/widgets/fade_animation.dart';
import 'package:movie_app/screens/movie_search_page.dart';

import '../models/movie.dart';
import 'favourite_movie_page.dart';
import 'main_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> favoriteMovies = [];

  int currentIndex = 0;
  late List<Widget> body;

  @override
  void initState() {
    super.initState();
    body = [
      const MainScreen(),
      SearchScreen(),
      FavouritePage(favoriteMovies: favoriteMovies),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 3,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: currentIndex,
          onTap: (int newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white),
                label: 'Search',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: Colors.white),
                label: 'Favourite',
                backgroundColor: Colors.black),
          ],
        ),
        body: body[currentIndex],
      ),
    );
  }
}
