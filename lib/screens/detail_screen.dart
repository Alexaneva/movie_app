import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/movie.dart';
import '../services/constants.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.movie});

  final Movie movie;

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
              // title: Text(
              //   movie.title,
              //   style: GoogleFonts.aBeeZee(
              //     fontSize: 17,
              //     color: Colors.white,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ), titlePadding: EdgeInsets.only(bottom: 20),
              // centerTitle: true,
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${movie.posterPath}',
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
                    movie.overview,
                    style: GoogleFonts.abhayaLibre(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
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
                          movie.voteAverage.toString(),
                          style: GoogleFonts.abhayaLibre(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(width: 130),
                        Text(
                         'Release date: ${movie.getReleaseDateTime().year}',
                          style: GoogleFonts.abhayaLibre(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.justify,
                        ),
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
}
