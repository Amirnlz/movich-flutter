import 'package:flutter/material.dart';
import 'package:movich/model/movie.dart';

class ExpandedDetails extends StatelessWidget {
  const ExpandedDetails({
    Key? key,
    required this.movieDetail,
  }) : super(key: key);

  final Movie movieDetail;

  List<Widget> getListedGenres(String genres) {
    List<Widget> listedGenre = [];
    for (String genre in genres.split(',')) {
      listedGenre.add(Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              genre,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    return listedGenre;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieDetail.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: getListedGenres(movieDetail.genre),
          ),
          Text(
            movieDetail.plot,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
