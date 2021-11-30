import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:movich/model/media/genre_data.dart';
import 'package:movich/model/result.dart';
import 'package:movich/pages/media/media_screen.dart';
import '../../rating_bar.dart';

class HorizontalListItem extends StatelessWidget {
  const HorizontalListItem({required this.result, Key? key}) : super(key: key);
  final Result result;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        depth: 8,
        lightSource: LightSource.left,
        shadowLightColor: Colors.grey.shade800,
        shadowDarkColor: Colors.black,
        color: const Color(0xFF08161a),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.86,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MediaScreen(result: result)),
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/original${result.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.005),
            AspectRatio(
              aspectRatio: 1.84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    GenreData(result.mediaType)
                        .getGenreNames(result.genreIds)
                        .join(', '),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.height * 0.005),
                  RatingBar(rating: result.voteAverage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
