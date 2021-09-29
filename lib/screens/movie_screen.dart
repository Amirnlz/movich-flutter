import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movich/model/movie.dart';
import 'package:movich/widgets/rotate_details.dart';
import 'package:movich/widgets/expanded_details.dart';

class MovieScreen extends StatelessWidget {
  final Movie movieDetail;

  const MovieScreen(this.movieDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        RotateDetails(movieDetail.released.split(' ').last,
                            Icons.calendar_today_rounded),
                        RotateDetails(movieDetail.runTime, Icons.access_time),
                        RotateDetails(movieDetail.rating, Icons.star_border),
                      ],
                    ),
                    Hero(
                      tag: movieDetail.imageUrl,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        child: Image(
                          image: NetworkImage(movieDetail.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
                ExpandedDetails(movieDetail: movieDetail),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
