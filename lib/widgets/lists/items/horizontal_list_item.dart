import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:movich/model/results.dart';
import 'package:movich/screens/media_screen.dart';
import '../../rating_bar.dart';

class HorizontalListItem extends StatelessWidget {
  const HorizontalListItem({required this.result, Key? key}) : super(key: key);
  final Results result;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        depth: 2,
        lightSource: LightSource.left,
        shadowLightColor: Colors.grey.shade800,
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
                  print(result.title);
                  print('id: ${result.id}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MediaScreen(results: result)),
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
            const SizedBox(
              height: 5,
            ),
            AspectRatio(
              aspectRatio: 1.84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    result.mediaGenre.join(', '),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
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
