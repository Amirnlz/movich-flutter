import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movich/screens/carousel_list.dart';
import 'package:movich/utilities/constants.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Movich',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        color: Colors.amberAccent,
                      ),
                    ),
                    Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  child: createCarouselList(
                    'Trending Movie',
                    MediaType.movie,
                    MediaListType.trending,
                  ),
                ),
                FadeInRight(
                  child: createCarouselList(
                    'Trending Tv',
                    MediaType.tv,
                    MediaListType.trending,
                  ),
                ),
                // TODO: Add slide here
                FadeInUp(
                  child: createCarouselList(
                    'Top Rated Movie',
                    MediaType.movie,
                    MediaListType.top_rated,
                  ),
                ),
                FadeInLeft(
                  child: createCarouselList(
                    'Top Rated TV',
                    MediaType.tv,
                    MediaListType.top_rated,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column createCarouselList(
      String title, MediaType mediaType, MediaListType mediaListType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _carouselListTitle(title),
        CarouselList(
          mediaType: mediaType,
          mediaListType: mediaListType,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Row _carouselListTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          'see all',
          style: TextStyle(
            fontSize: 14,
            decoration: TextDecoration.underline,
            color: Colors.lightBlue,
          ),
        ),
      ],
    );
  }
}
