import 'package:flutter/material.dart';
import 'package:movich/model/movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final Movie detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        Text(
          detail.genre,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Row(
          children: [
            RatingBarIndicator(
              rating: double.parse(detail.rating) / 2,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 16.0,
              direction: Axis.horizontal,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              detail.rating,
              style: const TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),
      ],
    );
  }
}
