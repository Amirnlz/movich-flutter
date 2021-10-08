import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBar extends StatelessWidget {
  final double rating;

  const RatingBar({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rating,
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
          rating.toString(),
        )
      ],
    );
  }
}
