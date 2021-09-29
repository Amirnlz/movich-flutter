import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movich/model/movie_data.dart';
import 'package:movich/widgets/image_details.dart';
import 'package:movich/constants.dart';
import 'movie_screen.dart';

class CarouselList extends StatefulWidget {
  const CarouselList({Key? key}) : super(key: key);

  @override
  State<CarouselList> createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList> {
  final MovieData movieData = MovieData();
  List movieList = [];

  void loadDetails() async {
    await movieData.createSeriesList();
    setState(() {
      movieList = movieData.getSeriesList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: const BoxDecoration(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          final movie = movieList[index];
          return Container(
            width: 200,
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieScreen(movie)),
                    );
                  },
                  child: Container(
                    height: 220,
                    width: 160,
                    decoration: kImageContainerDecoration,
                    child: Hero(
                      tag: movie.imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(movie.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ImageDetails(detail: movie),
              ],
            ),
          );
        },
        itemCount: movieList.length,
      ),
    );
  }
}
