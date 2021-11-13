import 'package:flutter/material.dart';
import 'package:movich/model/result.dart';
import 'package:movich/pages/media_screen.dart';
import 'package:movich/helpers/constants.dart';
import 'package:movich/widgets/rating_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class VerticalListItem extends StatefulWidget {
  final Result results;
  const VerticalListItem({required this.results, Key? key}) : super(key: key);

  @override
  _VerticalListItemState createState() => _VerticalListItemState();
}

class _VerticalListItemState extends State<VerticalListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AspectRatio(
        aspectRatio: 2.0,
        child: Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
            depth: 8,
            lightSource: LightSource.top,
            shadowDarkColor: Colors.black87,
            shadowLightColor: Colors.grey.shade800,
            color: const Color(0xFF08161a),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 0.8,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original${widget.results.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.results.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.results.genreIds.join(', '),
                              style: TextStyle(
                                color: Colors.grey[300],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RatingBar(rating: widget.results.voteAverage),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.results.overview,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            NeumorphicButton(
                              style: kButtonNeumorphicStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MediaScreen(result: widget.results),
                                  ),
                                );
                              },
                              child: const Text('Next'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
